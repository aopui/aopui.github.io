package com.aopui.effect.ease
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class DragEase extends EventDispatcher
	{
		public function DragEase()
		{
		}
		
		private var _parent:Sprite;
		private var _prop:String;
		private var _mouseValue:Number;
		private var _direction:String;
		private var _propTarget:Object;
		private var _reverse:Boolean=false;
		private var _ratio:Number;

		/**
		 * @param parent 要执行拖动缓东的对象 例：HBigDataList
		 * @param prop  要执行的缓东属性 例如  movX(hBigData.movX);
		 * @param propTarget 属性的宿主 例如 hBigData.movX 中 movX的宿主 是hBigData;
		 * @param direction 方向  横向 "H" 纵向 "V"
		 * @param reverse 滑动逆向
		 */
		public function setup(parent:Sprite,prop:String,propTarget:Object=null,direction:String="H",reverse:Boolean=false):void
		{
			_parent=parent;
			_prop=prop;
			_direction=direction;
			_propTarget=propTarget;
			_reverse=reverse;
			parent.addEventListener(MouseEvent.MOUSE_DOWN,onMDown);
			parent.addEventListener(MouseEvent.MOUSE_UP,onMUp);
		}
		
		public function deSetup():void
		{
			if(_parent.hasEventListener(Event.ENTER_FRAME))
				_parent.removeEventListener(Event.ENTER_FRAME,onEnterframe);
		}
		
		private function onMDown(e:MouseEvent):void{
			
			isDown=true;
			_parent.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			oldValue=mouseValue;
			
		}
		
		private function onMUp(e:Event):void
		{
			isDown=false;
			_parent.mouseChildren=true
		}		
		
		private function onMouseMove(e:MouseEvent):void
		{
			if(!_parent.hasEventListener(Event.ENTER_FRAME))
			{			
				addE();			
			}
			if(isDown)
			{
				_parent.mouseChildren=false;
			}
			_parent.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function addE():void
		{
			_parent.addEventListener(Event.ENTER_FRAME,onEnterframe);
		}
		
		private function get mouseValue():Number
		{
			if(_direction=="H")
				return _parent.stage.mouseX;
			else
				return _parent.stage.mouseY;
		}
		
		
		private function get prop():Number
		{
			if(_propTarget)
				return _propTarget[_prop] as Number;
			return _parent[_prop] as Number;
		}
		
		private function set prop(value:Number):void
		{
			if(_propTarget)
			{
				_propTarget[_prop]=value;
				return;
			}
			
			_parent[_prop]=value;
		}
		
		
		private var isDown:Boolean=false;
		private var dValue:Number=0;
		private var targetValue:Number;
		private var oldValue:Number=0;
		private function onEnterframe(e:Event):void		
		{
			
			if(isDown)
			{
				dValue = oldValue-mouseValue;
				oldValue=mouseValue;
			}
			else
			{

					dValue= (dValue*10-dValue)*.08;
					
					if(Math.abs(dValue)<0.5)
					{
						dValue = -1;
						_parent.removeEventListener(Event.ENTER_FRAME, onEnterframe);
					}
			}
			
			
			if(_reverse)
				prop+=dValue;
			else
				prop-=dValue;
		}
		
	}
	
	
}