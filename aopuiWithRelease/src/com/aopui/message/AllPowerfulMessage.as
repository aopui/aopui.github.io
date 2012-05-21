////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Oct 11, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.message
{
	public class AllPowerfulMessage
	{		
		public static const INIT_SCENE:String = "initScene";					
//		public static const INIT_FISHMAN:String = "initFishman";				
//		public static const INIT_FISHES:String = "initFishes";					
		public static const VISIT_FRIEND:String = "visitFriend";//访问好友家，切换场景之类的
		public static const SINGLECMD:String="#request#";
		
		
		public var param:Object;
		public var type:String;	//用户操作用 operation ,// request
		public var sequenceNum:int=0;
		public var otherParam:Object={};
		public var setp:int=1;
		
		
		
		[Selector]
		public var id:String;
		public static function create(id:String,param:Object=null,sequenceNum:int=0,type:String=""):AllPowerfulMessage
		{
			var msg:AllPowerfulMessage=new AllPowerfulMessage();
				msg.id=id;
				msg.type=type;
				msg.param=param;
				msg.sequenceNum=sequenceNum;
			return msg;
			
		}
		
		public static function createRequest(id:String,param:Object=null,sequenceNum:int=0):AllPowerfulMessage
		{			
			return create(id,param,sequenceNum,"request");			
		}
		
		/**
		 * 继续进行消息传递
		 */
		public function going():void
		{
			try{
				param.processor.proceed();
			}catch(o:Error){
				trace("消息中不含有processor:"+o.getStackTrace());
			};
		}
		
	}
}