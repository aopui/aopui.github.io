////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 21, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.admiral
{
	import com.aopui.ui.alert.Alert;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import spark.primitives.Graphic;

	public class PopupAdmiral
	{
		public static var popupLayer:Sprite;
		private static var isPoped:Boolean
		public function PopupAdmiral()
		{
			
		}
		
//		public  static function show(win:Sprite,mode:Boolean=true,left:Number=0,top:Number=0):void
//		{
//			if(isPoped)return;
//			isPoped=true;
//			while(popupLayer.numChildren)
//			{
//				popupLayer.removeChildAt(0);
//			}
//			if(mode)
//			{
//				popupLayer.graphics.beginFill(0x999999,.5);
//				popupLayer.graphics.drawRect(-5,-5,2500,2500);
//				popupLayer.graphics.endFill();
//			}
//			
//			left!=0?
//				win.x=left:				
//				win.x=popupLayer.stage.stageWidth/2-win.width/2;
//		
//			top!=0?
//				win.y=top:
//				win.y=popupLayer.stage.stageHeight/2-win.height/2;
//			popupLayer.addChild(win);			
//		}
		/**
		 * @param param
		 * 数结{txt:"",buttons:{label:"",callBack:}}
		 **/
		public static function alert(param:Object=null,alertWin:Class=null):DisplayObject
		{			
				if(!alertWin)
					alertWin=Alert;
				var d:DisplayObject=show(alertWin,param);
				if(param.effect)
					TweenMax.from(d,.5,param.effect);
				return d;
		}
		
		

		private static var alertedWin:DisplayObject
		private static var modelPanel:Sprite=new Sprite();
		/**
		 * @param param 
		 * 结构{mode:Boolean,left:Number,top:Number,bgColor:uint,alpha:Number,data:Object}<br>
		 * Example{mode=false,bgColor=0x0000ff,alpha:.3,left=0,top=0,data={}}
		 **/
		public  static function show(win:Class,param:Object=null):DisplayObject
		{
			if(isPoped)
				return alertedWin;
			isPoped=true;
			while(popupLayer.numChildren)
			{
				popupLayer.removeChildAt(0);
			}
			
			if(!param)param={mode:true}
				
//			if(param.mode)
//			{
//				var color:uint=0x000000;
//				var al:Number=.9;
//				if(param.bgColor)color=param.bgColor;
//				if(param.alpha)al=param.alpha;
//				popupLayer.graphics.beginFill(color,al);
//				popupLayer.graphics.drawRect(-5,-5,2500,2500);
//				popupLayer.graphics.endFill();
//			}
			var _win:Object=new win();
			param.left?
				_win.x=param.left:				
				_win.x=popupLayer.stage.stageWidth/2-_win.width/2;
			
			param.top?
				_win.y=param.top:
				_win.y=popupLayer.stage.stageHeight/2-_win.height/2;
			
			popupLayer.addChild(_win as DisplayObject);
			if(param.data)
			{
				try{_win.data=param.data}catch(o:Object){}				
			}
			if(param.mode)
			{
				var color:uint=0x000000;
				var al:Number=.9;
				if(param.bgColor)color=param.bgColor;
				
				if(param.alpha)al=param.alpha;
				popupLayer.graphics.beginFill(color,al);
				
				popupLayer.graphics.drawRect(0,0,popupLayer.stage.stageWidth,popupLayer.stage.stageHeight);
				popupLayer.graphics.endFill();
			}
			alertedWin=_win as DisplayObject;
			return alertedWin;
		}
		
		
		
		public static function close():void
		{
			while(popupLayer.numChildren)
			{
				popupLayer.removeChildAt(0);
			}
			popupLayer.graphics.clear();
			isPoped=false;
		}
	}
}