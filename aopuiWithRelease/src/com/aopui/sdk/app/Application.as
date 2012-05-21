/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-8-24
* Michael
*/
package com.aopui.sdk.app
{
	import com.aopui.event.EventBase;
	import com.aopui.sdk.module.ModuleAdmiral;
	
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.system.ApplicationDomain;
	
	import org.spicefactory.parsley.core.context.Context;

	public class Application implements IApplication
	{
		private static var _app:Application;
		
		private var _serviceUrl:String;
		private var _baseUrl:String;
		private var _uid:String;
		private var _sessionId:String;
		private var _context:Context;
		private var _applicationDomain:ApplicationDomain;
		private var _moduleManager:ModuleAdmiral;
		private var _scene:Sprite;
		
		public static var loaders:Array=[];
		public function Application(en:SingletonEnforcer)
		{
		}
		
		public static function get app():IApplication
		{
			if (!_app)
			{
				_app = new Application( new SingletonEnforcer() );
				_app._applicationDomain = ApplicationDomain.currentDomain;
				//GlobalFactoryRegistry.instance.messageSettings.commandFactories.addCommandFactory(ServerInteractionToken,
																//new ServerInteractionCommandFactory());
//				GlobalFactoryRegistry.instance.messageSettings.commandFactories.addCommandFactory(URLLoader,
//																	new URLLoaderCommandFactory());
				
			}
			return _app;
		}
		
		public function get context():Context
		{
			return _context;
		}

		public function set context(value:Context):void
		{
			if ( !_context )
				_context = value;
		}

		public function get sessionId():String
		{
			return _sessionId;
		}

		public function set sessionId(value:String):void
		{
			_sessionId = value;
		}

		public function get uid():String
		{
			return _uid;
		}

		public function set uid(value:String):void
		{
			_uid = value;
		}

		public function get baseUrl():String
		{
			return _baseUrl;
		}

		public function set baseUrl(value:String):void
		{
			_baseUrl = value;
		}

		public function get serviceUrl():String
		{
			return _serviceUrl;
		}

		public function set serviceUrl(value:String):void
		{
			_serviceUrl = value;
		}
		
		public function get applicationDomain():ApplicationDomain
		{
			return _applicationDomain;
		}
		
/*		public function get stage():Stage
		{
			return _stage;
		}*/
		
/*		public function get appContainer():AppContainer
		{
			return _appContainer;
		}*/
/*		public function set stage( value:Stage ):void
		{
			_stage = value;
		}*/
		
		/**
		 * 装配模块配置文件，启动 App
		 */
		public function assemble(assembler:XML):void
		{
			_moduleManager = new ModuleAdmiral(assembler);
			_moduleManager.addEventListener("moduleLoaded",moduleLoaded);
			_moduleManager.loadStartupModules();
		}
		private function moduleLoaded(e:EventBase):void
		{			
			this.scene.stage.dispatchEvent(EventBase.createEvent("showLoadingTxt",{txt:"完成["+e.message.txt+"]加载"}));
		}
		
		/**
		 * 启动一个模块
		 */
		public function startModule(moduleId:String):void
		{
			if (_moduleManager)
				_moduleManager.loadModule(moduleId);
		}
		
		public function set scene( value:Sprite ):void
		{
			this._scene = value;
		}
		
		public function get scene():Sprite
		{
			return _scene;
		}
		
		public function get frameRate():int
		{
			return _scene.stage.frameRate;
		}
		
		public function get width():Number
		{
			return _scene.stage.stageWidth;
		}
		
		public function get height():Number
		{
			return _scene.stage.stageHeight;
		}
	}
}

class SingletonEnforcer{}