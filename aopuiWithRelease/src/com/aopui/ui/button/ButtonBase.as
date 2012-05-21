/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui.button
{
	import com.aopui.ui.txt.TxtBase;
	
	import flash.geom.Rectangle;
	
	public class ButtonBase extends TxtBase
	{
		public function ButtonBase()
		{
			super();
			this.width=130;
			this.height=45;
		}
		override public function layout():void
		{
			super.layout();
			
//				if(this._bgInstance&& this._bgInstance.width>this._textField.textWidth+4+marginLeft*2 || this._bgInstance&&_textString=="")
//				{
//					this.width=_bgInstance.width;
//				}
//				else
//				{
//					this.width=this._textField.textWidth+4+marginLeft*2;
//				}
//				
//				if(this._bgInstance&& this._bgInstance.height>this._textField.textHeight+4+marginTop*2 || this._bgInstance&&_textString=="")
//				{
//					this.width=_bgInstance.width;
//				}
//				else
//				{
//					this.height=this._textField.textHeight+4+marginTop*2;
//				}
			
		}
	}
}