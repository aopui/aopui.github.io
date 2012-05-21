////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 26, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.ui.area
{
	import com.aopui.ui.txt.TxtBase;
	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class AreaBase extends TxtBase
	{
		public function AreaBase()
		{
			super();
			_textField.multiline=true;
			_textField.wordWrap=true;
			_textField.mouseEnabled=true;
//			_textField.autoSize=TextFieldAutoSize.LEFT;
//			_textField.thickness=-20;
//			_textField.
			_textField.selectable=false;
		}
		
		
		
		
		override public function layout():void
		{
			
		}
		
		override public function set width(value:Number):void
		{
			super.width=value;
			_textField.width=value;
		}
		
		override public function set height(value:Number):void
		{
			super.height=value;
			_textField.height=value;
		}
		
		public function getRealHeight():Number
		{
			var h:Number=this._textField.height=_textField.textHeight+4;
			return h;
		}
		
		override public function  set htmlText(txt:String):void
		{
			if(_textField.text==txt)return;
			_textField.defaultTextFormat=new TextFormat("微软雅黑",12,null,false);
//			_textField.setTextFormat(new TextFormat("微软雅黑",12,null,false));
			_textField.htmlText=txt;
			
			this.invalidate();
		}
		
//		override public function set text(txt:String):void
//		{	
//			if(_textField.text==txt)return;
//			this._textString=txt;
//			_textField.defaultTextFormat=new TextFormat(null,12,null,true);
//			_textField.text=txt;
//			if(!input)
//				this.invalidate();
//		}
	}
}