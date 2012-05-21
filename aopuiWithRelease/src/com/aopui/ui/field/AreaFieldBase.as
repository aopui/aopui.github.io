////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 26, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.ui.field
{
	import com.aopui.ui.Area;
	import com.aopui.ui.Label;
	import com.aopui.ui.VBox;
	
	public class AreaFieldBase extends VBox
	{
		private var _nameLabel:Label=new Label();
		private var _valueLabel:Area=new Area();
		private var _label:String;
		private var _value:String;
		public function AreaFieldBase()
		{
			this.verticalGap=1;
			this.marginTop=0;
			super();
			
			this.data=[_nameLabel,_valueLabel];
		}
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if(value==_label)return;
			_label = value;
			_nameLabel.text=value;
			this.invalidate();
		}
		
		public function get value():String
		{
			return _value;
		}
		public function setHtmlValue(value:String):void
		{
			if(value==_value)return;
			_value = value;
			_valueLabel.htmlText=value;
			this.invalidate();
		}
		
		public function set value(value:String):void
		{
			if(value==_value)return;
			_value = value;
			_valueLabel.text=value;
			this.invalidate();
		}
		override public function set width(value:Number):void
		{
			var lw:Number=this._nameLabel.width;
			super.width=value;
			this._nameLabel.width=lw;
			this._valueLabel.width=value;
			this.invalidate();
		}
		
//		override public function layout():void
//		{
//		
//		}
	}
}