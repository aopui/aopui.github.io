/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-8-26
* Michael
*/
package com.aopui.command
{
	import com.adobe.serialization.json.JSON;
	import com.aopui.Marshal;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.model.GlobalModel;
	import com.aopui.sdk.app.Application;
	import com.aopui.sdk.error.JSONInvalidError;
	import com.aopui.sdk.error.SessionExpiredError;
//	import com.aopui.sdk.io.service.ServerInteractionToken;
	
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	public class InteractionCommandBase
	{
		protected var params:URLVariables;
		protected var apiMethod:String="";
		protected var resultData:Object;
		
//		private var _token:ServerInteractionToken;
		
		[MessageDispatcher]
		public var dispather:Function;
		
		[Inject]
		public var marshal:Marshal;
		[Inject]
		public var globalModel:GlobalModel;
		
		
		public function InteractionCommandBase()
		{
			
		}
		
		public function execute (event:AllPowerfulMessage) :URLLoader
		{
			params = new URLVariables();
			if(apiMethod=="")apiMethod=event.id;
			var param:Object=event.param;
			if(param)
			{				
				for (var prop:String in param)
				{
					if(prop=="api")
					{
						apiMethod=param[prop];
					}
					else
					{
						params[prop]=param[prop];
					}
				}
			}
			return baseExecute();
		}
		
		
		protected function baseExecute():URLLoader
		{
			var urlLoader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(GlobalModel.params[GlobalModel.serviceField][0]);
			request.method = GlobalModel.requestType;
		
			
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.load(request);
			if(!params)
				params = new URLVariables();
			if(!GlobalModel.ationString||GlobalModel.ationString=="")
				params["method"] = apiMethod;
			else
				params[GlobalModel.ationString] = apiMethod;
			for(var s:String in GlobalModel.params)
			{
				if(s.indexOf(GlobalModel.cfgParamPrefix)==-1)
				{
					if(ExternalInterface.available)
						params[s]=Application.app.scene.stage.loaderInfo.parameters[s];
					else
						params[s]=GlobalModel.params[s][0];
				}
			}
//			params["rk_uid"] = App.app.uid;
//			params["rk_sig"] = App.app.sessionId;
			request.data = params;
			urlLoader.load(request);
			return urlLoader;
		}
		
		protected function doResult():Object
		{
			return null;
		}
		
		//真正的错误   还需要一个  处理服务器返回错误编码的函数
		public function error (fault:Event) : void
		{	
			trace("fault!");// do something with the result
		}
		
		
		
		/**
		 * Parse the string result to the json format.
		 * Errors: SessionExpiredError, JsonInvalidError
		 * @param data result for http request.
		 */ 
		//We need an Error handler to handle all the errors.
		public function result(data:String):void
		{		
			resultData = {};
			try
			{
				resultData = com.adobe.serialization.json.JSON.decode(data);
			}
			catch (e:Error)
			{
				throw new JSONInvalidError();//JSON 解析错误
			}
					
			if (resultData.return_code == 100 || (resultData.state == "err"))
			{                
//				throw new SessionExpiredError();//Session
				marshal.showLoadingTxt("SESSION过期");
			}
			
			var r:Object=doResult();
			if(resultData&&resultData.extra_info)
					this.globalModel.DNA.userInfo=resultData.extra_info;
			dispather(AllPowerfulMessage.create("BACK_"+apiMethod,resultData));
			
			
			/*执行过来的 selector在发送一个返回结果的Message
				规则是 selector+data
			*/
			
			//TODO WK我给注解了这个 服务器传回来候派发这个消息
			//			dispather(new ServerInteractionResponseMsg(resultData));
			
			//serverNow = jsonData.server_now;//当前的服务器时间
	
			
			//TODO 赠送礼物相关的逻辑
			/*			if(jsonData && jsonData.extra_info) 
			{
			model.dealWithExtra(jsonData.extra_info);           	
			
			var msg:String = jsonData.extra_info["level_gifts_str"];	// 升级事件中系统赠送的礼物 显示赠送礼物提示
			
			if(Boolean(msg)) 
			{
			model.isBuy = true;
			//提示升级成功框
			UpdateAlertWindows.show(getText("updatetip"), msg, AlertType.SUCCESS, true, false, false);
			}
			//  DeadRookieMissionManager.getInstance().initData(jsonData.extra_info.rookie_mission, Boolean(msg));
			model.dealRookieMission(jsonData.extra_info);
			}*/
			
			//执行事件触发者的处理动作
			//doResult(jsonData);
			
			//callBackHandle(CallbackFlag.SUCCESS, jsonData);
			//hideBusy();    
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Private 
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*		private function generateToken(loader:URLLoader):ServerInteractionToken
		{
			var token:ServerInteractionToken = new ServerInteractionToken(loader);
			
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
		}
		
		private function removeEventHandlers( target:IEventDispatcher ):void
		{
			target.removeEventListener(Event.COMPLETE, completeHandler);
			target.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
		}
		
		private function completeHandler(event:Event):void
		{
			_token.dispatchEvent(new ServerInteractionEvent(ServerInteractionEvent.INTERACTION_SUCCESS));
		}
		
		private function errorHandler(event:Event):void
		{
			_token.dispatchEvent(new ServerInteractionEvent(ServerInteractionEvent.INTERACTION_FAILED));
		}*/
	}
}