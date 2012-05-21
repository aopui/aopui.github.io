/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 19, 2010
* WUSHIHUAN
*/
package com.aopui.ui.label
{
	import com.aopui.ui.txt.TxtBase;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class LabelBase extends TxtBase
	{		
		public function LabelBase()
		{
			super();
			this.width=200;
			this.height=30;
			needBGEffect=false;
		}
		
		override public function set barSkinClass(skin:Class):void
		{
//			this.barInstance=new skin();
//			this.bgLayer.addChild(this.barInstance);
		}
		
		override public function layout():void
		{
			super.layout();
//			if(autoSize)
//			{
//				if(this._bgInstance&& this._bgInstance.width>this._textField.textWidth+4+marginLeft*2 ||_textString=="")
//				{
//					this.width=_bgInstance.width;
//				}
//				else
//				{
//					this.width=this._textField.textWidth+4+marginLeft*2;
//				}
//				
//				if(this._bgInstance&& this._bgInstance.height>this._textField.textHeight+4+marginTop*2 ||_textString=="")
//				{
//					this.width=_bgInstance.width;					
//				}
//				else
//				{
//					this.height=this._textField.textHeight+4+marginTop*2;
//				}
//				
//				
//			}
//			if(this.barInstance)
//			{
//				this.barInstance.width=this._bgInstance.width;
//				this.barInstance.height=this._bgInstance.height;
//				this.barInstance.x=_bgInstance.x;
//				this.barInstance.y=_bgInstance.y;
//				if(this.text.indexOf("/")!=-1)
//				{
//					var arr:Array=this.text.split("/");
//					var value:Number=arr[0];
//					var max:Number=arr[1];
//					this.barInstance.width=this._bgInstance.width*(value/max);
//				}
//			}			
//			super.layout();
		}
	}
}