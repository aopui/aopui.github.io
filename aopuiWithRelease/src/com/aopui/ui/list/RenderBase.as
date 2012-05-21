/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
//out 1,over 2,click 3,select 4
package com.aopui.ui.list
{
	import com.aopui.admiral.CursorAdmiral;
	import com.aopui.core.IToolTipClient;
	import com.aopui.core.inside;
	import com.aopui.ui.BasicUI;
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class RenderBase extends BasicUI implements IToolTipClient
	{
		public var index:int;
		public var currentPageLength:int;
		public var maxLength:int;
		private var _data:Object;
		private var _selected:Boolean=false;		
		private var _needBGEffect:Boolean=true;
		private var _cursor:Object;
		private var _cmd:String;
		
		private var _toolTip:Object;
		public var scaleEffect:Boolean=false;
		
		public function RenderBase()
		{
			super();
//			this.mouseChildren=false;
			needBGEffect=true;
		}
		
		
		public function get cmd():String
		{
			return _cmd;
		}

		public function set cmd(value:String):void
		{
			_cmd = value;
		}

		public function get cursor():Object
		{
			return _cursor;
		}

		public function set cursor(value:Object):void
		{
			_cursor = value;
			this.addEventListener(MouseEvent.CLICK,checkCursor);
		}
		
		private function checkCursor(e:Event):void
		{
			if(this._cursor)
				CursorAdmiral.setCursor(this);
		}

		public function get needBGEffect():Boolean
		{
			return _needBGEffect;
		}

		public function set needBGEffect(value:Boolean):void
		{
			_needBGEffect = value;
			if(_needBGEffect)
			{
				listen();
			}
			else
			{
				unListen();
			}
		}

		private function listen():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		private function unListen():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_UP,onMouseOut);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		protected function onMouseOut(e:Event):void
		{
				onOut();
			
		}
		protected function onMouseOver(e:Event):void
		{
				onOver();
		}
		
		
		
		public function get selected():Boolean
		{
			return _selected;
			
		}
		
		public function set toolTip(value:Object):void
		{
			this._toolTip=value;
		}
		public function get toolTip():Object
		{
			return this._toolTip;
		}
		private var _toolTipClass:String
		public function set toolTipClass(value:String):void
		{
			_toolTipClass=value;
		}
		public function get toolTipClass():String
		{
			return _toolTipClass;
		}
		private var _toolTipType:String;
		[Inspectable(enumeration="vertical","random")]
		public function set toolTipType(value:String):void
		{
			_toolTipType=value;
		}		
		
		public function get toolTipType():String
		{
			return _toolTipType;
		}		
		
		public function onOver():void
		{
			if(_selected)return;
			if(scaleEffect)
				scaleEffectOver();
			else				
				bgGoStop(2);
		}
		
		public function onOut():void
		{
			if(_selected)return;
			
			if(scaleEffect)
				scaleEffectOut();
			else	
				bgGoStop(1);
		}
		public function onClick():void
		{	if(_selected)return;
			bgGoStop(3);
		}
		public function onSelect():void
		{	if(_selected)return;
			bgGoStop(4);
		}
		private var startPoint:Point;
		private var endPoint:Point
		private var animationW:Number;
		private var animationH:Number;
		private function resetStartAndEndPoint():void
		{
			this.width=animationW;
			this.height=animationH;
			if(!animationH)
			{
				animationH=this.height;
				animationW=this.width;
			}
		
			startPoint=new Point(this.x,this.y);
			endPoint=new Point(this.x-(animationW*1.2-animationW)/2,this.y-(animationH*1.2-animationH)/2);
		}
		private var tween:TweenMax
		private function scaleEffectOver():void
		{
		
			
			if(this.filters.length>0)
				return;
			if(tween)
				tween.kill();
			tween=TweenMax.to(this,.5,{scaleX:1.2,scaleY:1.2,x:endPoint.x,y:endPoint.y});
		}
		private function scaleEffectOut():void
		{
			if(tween)
				tween.kill();
			tween=TweenMax.to(this,.5,{scaleX:1,scaleY:1,x:startPoint.x,y:startPoint.y});
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			setSelect(_selected);
		}
		
		public function setSelect(v:Boolean):void
		{
			if(v)
			{
				bgGoStop(4);
			}
			else
			{
				bgGoStop(1);
			}
		}

		public function set data(d:Object):void
		{
			_data=d;
				try{
				if(d.skin)
				{
					this.skinClass=d.skin;
				}
				if(d.cursor)
				{
					this.cursor=d.cursor;
				}
				if(d.cmd)
				{
					this.cmd=d.cmd;
				}
			}catch(e:Object){}
			TweenMax.delayedCall(.1,layout);
		}
		
		override public function layout():void
		{
			super.layout();
			var i:int=0;
			while(i<this.contentLayer.numChildren)
			{
				var disp:DisplayObject=contentLayer.getChildAt(i);
				if(disp is BasicUI)
				{
					BasicUI(disp).layout();
				}
				i++;
			}
			if(this.scaleEffect)
			resetStartAndEndPoint();
			
		}
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if(child is BasicUI)
				Object(child).parentui=this;
			return super.addChild(child);
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function setParam(param:Object):void
		{
			
		}
		
		public function destroy():void
		{
			
		}
	}
}