package com.aopui.ui.pluginView
{
	import com.aopui.event.pluginEvent.PluginNumPanelEvent;
	import com.aopui.event.pluginEvent.PluginSliderEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	public class PluginSlider extends EventDispatcher
	{
		private var sliderContent:Object;
		private var thumb:Sprite;
		private var track:MovieClip;
		private var _value:Number;
		public function PluginSlider(sliderContent:Object)
		{
			this.sliderContent=sliderContent;
		  	thumb=sliderContent["thumb"] as Sprite;
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			thumb.buttonMode=true;
			track=sliderContent["sliderTrack"] as MovieClip;			
			track.gotoAndStop(0);
			thumb.addEventListener(Event.ADDED_TO_STAGE,addToStage);
		}
		
		private function addToStage(e:Event):void
		{
			thumb.stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
		}
		
		private var _mouseDown:Boolean
		protected function mouseDown(e:MouseEvent):void
		{
			_mouseDown=true;
			sliderContent.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function tracking():void
		{
			if(!max)
				return;
			oldY=thumb.y+0;
//			thumb.startDrag();
			thumb.y=0;
			thumb.y=0;
			thumb.x=thumb.parent.globalToLocal(new Point(thumb.stage.mouseX,0)).x-thumb.width/2;
			if(thumb.x>track.width-thumb.width)
			{
				thumb.x=track.width-thumb.width;
			}
			if(thumb.x<0)
			{
				thumb.x=0;
				mouseUp(null);
			}			
			var value:int=int(thumb.x/(track.width-thumb.width)*100);
			this.value=value;
			setTrackFrame(value);
		}
		
		private var oldY:Number;
		protected function onMouseMove(e:MouseEvent):void
		{
			tracking();
		}
		
		protected function mouseUp(e:MouseEvent):void
		{
			if(!_mouseDown)
				return;
			_mouseDown=false;
//			thumb.stopDrag();
			sliderContent.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			
			if(thumb.x>track.width-thumb.width)
			{
				thumb.x=track.width-thumb.width;
			}
			if(thumb.x<0)
			{
				thumb.x=0;
				mouseUp(null);
			}
			
			thumb.y=0;
			_value=int(thumb.x/(track.width-thumb.width)*100);	
			this.realValue=Math.ceil(_value/100*this.max);//(track.width-thumb.width)*(_value/100);
			setTrackFrame(_value);
			this.dispatchEvent(new Event(PluginSliderEvent.SLIDER_CHANGE));
		}
		
		public function get value():int
		{
			return _value
		}
		
		public function set value(value:int):void
		{
			this._value=value;
			setTrackFrame(_value);
			thumb.x=(track.width-thumb.width)*(_value/100);
			_realValue=int(max*(_value/100));
		}
		
		private var _realValue:int
		public function set realValue(value:int):void
		{
			_realValue=value;
			var frameValue:int=int(value/max*100)
			this.value=frameValue;
		}
		
		public function get realValue():int
		{
			return _realValue;
		}
		
		private var _max:int
		private var _min:int;
		
		private function setTrackFrame(value:int):void
		{
			track.gotoAndStop(value);
		}

		public function get max():int
		{
			return _max;
		}

		public function set max(value:int):void
		{
			_max = value;
		}

		public function get min():int
		{
			return _min;
		}

		public function set min(value:int):void
		{
			_min = value;
		}
	}
}