package com.aopui.ui
{
	public class TextArea extends Panel
	{
		public function TextArea()
		{
			super();
			xml=<layout width="100" height="100">
					<Area id="area" right="0" left="0" top="0" bottom="0"/>
				</layout>
		}
				
		override public function layout():void
		{
			super.layout();
			if(this.pageEffect)
				$.area.width=this.width-this.pageEffect.getVerticalScrollBarW();
			else
				$.area.width=this.width;

				$.area.height=$.area.getRealHeight();
//			super.layout();
		}
		
		public function set text(value:String):void
		{
			$.area.text=value;
			this.invalidate();
		}
		
		override public function set font(value:Object):void
		{
			$.area.font=value;
			this.invalidate();
		}
		
		override public function get font():Object
		{
			return $.area.font;
		}
		
		public function get text():String
		{
			return $.area.text;
		}
		
		public function set htmlText(value:String):void
		{
			$.area.htmlText=value;
			this.invalidate();
		}
		
		public function get htmlText():String
		{
			return $.id.area.htmlText;
		}
	}
}