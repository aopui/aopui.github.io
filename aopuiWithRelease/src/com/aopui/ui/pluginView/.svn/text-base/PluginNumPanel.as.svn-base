package com.aopui.ui.pluginView
{
	import com.aopui.event.EventBase;
	import com.aopui.event.pluginEvent.PluginNumPanelEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class PluginNumPanel extends EventDispatcher
	{
		private var numContent:Object;
		public function PluginNumPanel(numContent:Object)
		{
			this.numContent=numContent;
			if(numContent.hasOwnProperty("plusBtn"))
			{
				numContent["plusBtn"].addEventListener(MouseEvent.CLICK,add);
			}
			if(numContent.hasOwnProperty("minusBtn"))
			{
				numContent["minusBtn"].addEventListener(MouseEvent.CLICK,sub);
			}
			var t:TextField
			numContent["numBox"].addEventListener(Event.CHANGE,onChange);
			numContent["numBox"].restrict="0-9";
		}
		
		public function onChange(e:Event):void
		{
			if(int(numContent["numBox"].text)>_max)
			{
				numContent["numBox"].text=_max+"";
//				return;
			}
			if(int(numContent["numBox"].text)<_min)
			{
				numContent["numBox"].text=_min+"";
//				return;
			}
			this.dispatchEvent(
							EventBase.createEvent(
								PluginNumPanelEvent.NUMBER_CHANGE,{value:int(numContent["numBox"].text),target:this}
												)
							);
		}
		
		public function set text(value:String):void
		{
			numContent["numBox"].text=value;
		}
		public function get text():String
		{
			
			return numContent["numBox"].text;
		}
		private var _min:int=0;
		public function set min(value:int):void
		{
			_min=value;
		}
		public function get min():int
		{
			return _min;
		}
		
		private var _max:int=0;
		public function set max(value:int):void
		{
			_max=value;
		}
		
		public function get max():int
		{
			return _max;
		}
		
		public function add(e:Object=null):void
		{
			text=int(text)+1+"";
			onChange(null);
		}
		public function sub(e:Object=null):void
		{
			text=int(text)-1+"";
			onChange(null);
		}
		
	}
}