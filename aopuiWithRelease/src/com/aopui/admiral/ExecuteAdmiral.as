package com.aopui.admiral
{
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	public class ExecuteAdmiral extends Sprite
	{
		public function ExecuteAdmiral()
		{
			
		}
		
		
		
		/*
		 * 
		
		
		*/
		
		private static var process:NativeProcess;
		private static var _callBack:Function;
		private static var _endCallBack:Function;
		private static var _onErr:Function;
		/**
		 * 
		 * @param path 可执行文件路径
		 * @param params 参数
		 * @param callBack 用于取得执行后的回馈 传入的参数是 process:NativeProcess
		 * @param endCallBack 线程结束
		 * 
		 */
		public static function start(path:String,params:Array=null,callBack:Function=null,endCallBack:Function=null,errCallBack:Function=null):void
		{
			_callBack=null;
			_endCallBack=null;
			_onErr=null;
			_callBack=callBack;
			_endCallBack=endCallBack;
			_onErr=errCallBack;
			NativeApplication.nativeApplication.autoExit=true;
			var file:File=File.applicationDirectory;
			file=file.resolvePath(path);
			
			var nativeProcessStartupInfo:NativeProcessStartupInfo
			
			nativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.arguments=Vector.<String>(params);
			nativeProcessStartupInfo.executable = file;
//			if(params)
//			{
//				for each(var p:String in params)
//				{
//					nativeProcessStartupInfo.arguments.push(p);
//				}
//			}
			process = new NativeProcess();
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,onComp);
//			process.addEventListener(ProgressEvent.STANDARD_INPUT_PROGRESS,onComp);
			process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA,onErr);
//			process.addEventListener(Event.COMPLETE,onComp);
			process.addEventListener(Event.STANDARD_OUTPUT_CLOSE,endComp);
			process.start(nativeProcessStartupInfo);
			
		}
		private static function endComp(e:Event):void
		{
			if(_endCallBack!=null)
			_endCallBack();
		}
		
		private static function onErr(e:ProgressEvent):void
		{
			if(_onErr!=null)
				_onErr(process);
		}
		private static function onComp(e:Event):void
		{
//			var s:String=process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable);
			if(_callBack!=null)
				_callBack(process);
		}
		
	}
}