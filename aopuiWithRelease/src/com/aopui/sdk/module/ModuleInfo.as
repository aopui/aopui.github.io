/*
* Copyright(c) 2010 www.AOPUI.COM, All rights reserved.
* 2010-8-3
* Michael
*/
package com.aopui.sdk.module
{
	import com.aopui.sdk.app.Application;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	[Event(type="com.aopui.sdk.module.ModuleCompleteEvent",name="moduleComplete")]
	public class ModuleInfo extends EventDispatcher
	{
		public var id:String;
		public var version:String;
		public var url:String;
		public var content:*;
		public var info:XML;
		
		private var _loader:Loader;
		private var _xmlLoader:URLLoader;
		private var _instance:IAppModule;
		private var _initialized:Boolean;
		private var _batchToken:uint;
		
		private var _type:String;
		
		public function ModuleInfo(data:*, token:uint)
		{
			deserialize(data);
			_batchToken = token;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get ready():Boolean
		{
			return _initialized;
		}
		
		public function get token():uint
		{
			return _batchToken;
		}
		//Module Data
		//<module id="rookie" v="1.0.0.272416" url="E:/Michael/Projects/RekooGameSDK/workspace/demo-module-rookie/bin-debug/RookieModule.swf" />;
		/**
		 * 读取XML文件，解析数据
		 * 跟据需要可以启用 lazy initialize.
		 */
		public function deserialize(info:XML):void
		{
			this.info = info;
			id = info.@id;
			version = info.@v;
			url = info.@url;
			type=info.name();
		}
		
		/**
		 * 用于获取实例
		 * @throw ModuleIncompleteError.
		 */
		public function get instance():IAppModule
		{
			if (!_instance)
				throw new ModuleIncompleteError(); 
			else
				return _instance;
		}
		
		public function set instance(ins:IAppModule):void
		{
			_instance=ins;
			_initialized=true;
		}
		public static var loaderContext:LoaderContext = new LoaderContext(false, Application.app.applicationDomain);
		public function load():void
		{
			if(type=="xml")
			{
				if ( version == "" )
					url += ("?v=" + Math.random());
				_xmlLoader=new URLLoader(new URLRequest(url));
				_xmlLoader.addEventListener(Event.COMPLETE, loadCompleteHandler);
				return;
			}
				
				
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			if ( version == "" )//如果没有版本号，需要加入随机数，防止读取缓存中的文件
				url += ("?v=" + Math.random());
			_loader.load( new URLRequest(url), loaderContext );
		}
		
		private function loadCompleteHandler(event:Event):void
		{
			_initialized = true;
			if(this.type=="resource"){
				Application.loaders.push(_loader);
				dispatchEvent(new ModuleCompleteEvent());
				return;
			}
			if(this.type=="xml")
			{
				this.content=_xmlLoader.data;
				dispatchEvent(new ModuleCompleteEvent());
				return;
			}
			if(this.type=="font")
			{
				dispatchEvent(new ModuleCompleteEvent());
				return;
			}
			_instance = IAppModule(_loader.content);
			dispatchEvent(new ModuleCompleteEvent());
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			//TODO 容错处理
			//throw new Error("Load Module IOError!");
			trace(event.text);
		}
	}
}