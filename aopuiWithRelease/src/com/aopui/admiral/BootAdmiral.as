////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Oct 18, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.admiral
{
	import com.aopui.model.GlobalModel;
	import com.aopui.sdk.app.Application;
	import com.aopui.sdk.preloader.IPreloader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.spicefactory.lib.logging.LogContext;

	public class BootAdmiral
	{
		private var _preloaderFactory:IPreloader;
		private var _assemblerLoader:URLLoader;		
		private var t:Timer;
		protected var baseUrl:String;
		protected var sessionId:String;
		protected var serviceUrl:String;
		protected var uid:String;
		public var  ASSEMBLER_URL:String = "assembler.xml";
		public function BootAdmiral()
		{
			
		}
		
		public function init(factory:IPreloader):void
		{
//			TODO: 关闭了logFactory 需要时候可以打开
//			var logFactory:FlashLogFactory = new DefaultLogFactory();
//			logFactory.setRootLogLevel(LogLevel.INFO);//默认把Log关闭，减少 log trace 的量，提高程序的运行速度
//			LogContext.factory = logFactory;
			_preloaderFactory = factory;
			_preloaderFactory.showPromptLabel("载入配置文件..." );
			_preloaderFactory.showProgress( 10 );
			
			var url:String = ASSEMBLER_URL + "?r=" + getTimer().toString() + Math.random()*9999;
			_assemblerLoader = new URLLoader();
			_assemblerLoader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			_assemblerLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_assemblerLoader.load( new URLRequest(url));
		}
		
		private function loadCompleteHandler(event:Event):void
		{	
			_preloaderFactory.showPromptLabel("开始载入模块...");
			var assembler:XML = new XML(_assemblerLoader.data);
			var app:Application = Application(Application.app);
			app.serviceUrl = _preloaderFactory.stage.root.loaderInfo.parameters.app_url;
			app.baseUrl = _preloaderFactory.stage.root.loaderInfo.parameters.self_url;
			app.uid = _preloaderFactory.stage.root.loaderInfo.parameters.uid;
			app.sessionId = _preloaderFactory.stage.root.loaderInfo.parameters.session_value;
			app.scene = _preloaderFactory.sceneLayer as Sprite;
			app.baseUrl = baseUrl;
			app.serviceUrl=serviceUrl;
			app.sessionId=sessionId;
			app.uid=uid;
			app.assemble( assembler );
			_assemblerLoader.close();
			_assemblerLoader = null;
		}
		
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("配置文件读取错误");
		}
		
		public function set params(value:Object):void
		{
			GlobalModel.params=value;
		}
	}
}