////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 27, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.admiral
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;

	public class CursorAdmiral
	{
		
		public static var cursorLayer:Sprite;
		public static var cursorClass:Class;
		private static var cursorInstance:Sprite;
		public static var showMouseCursor:Boolean=false;
		public static var gameLayer:Sprite;
		public static var cursorObject:Object;
		public static var preCursorObject:Object;
		public function CursorAdmiral()
		{
		}
		public static function setCursor(target:Object):void
		{
			if(!target.cursor)
				return;
			if(cursorClass==target.cursor)
				return;
			if(target.cursor=="non")
			{
				destroyCursor();
				return;
			}
			if(cursorObject)
				preCursorObject=cursorObject;
			cursorObject=target;			
			cursorClass=target.cursor as Class;
			while(cursorLayer.numChildren)
			{
				cursorLayer.removeChildAt(0);
			}
			cursorInstance=new cursorClass();
		
			var p:Point;
			if(target.hasOwnProperty("x")&& target.hasOwnProperty("y")&&!(target is DisplayObject))
			{
				p=new Point(target.x,target.y);
			}
			else
			{
				p=target.parent.localToGlobal(new Point(target.x,target.y));
			}
			cursorInstance.x=p.x;
			cursorInstance.y=p.y;
			cursorLayer.addChild(cursorInstance);
				cursorLayer.stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			if(cursorInstance is MovieClip)
			{
				cursorLayer.stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			}
		}
		public static function undo(param:Object):void
		{
			if(!preCursorObject ||(preCursorObject && preCursorObject.cursor==cursorClass))
				destroyCursor();
			else
				setCursor({cursor:preCursorObject.cursor,x:param.x,y:param.y});
		}
		public static function destroyCursor():void
		{
			cursorLayer.stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			while(cursorLayer.numChildren)
			{
				cursorLayer.removeChildAt(0);
			}
			cursorObject=null;
			preCursorObject=null;
			cursorClass=null;
			cursorInstance=null;
			Mouse.show();
		}
		public static function getCursorInstance():DisplayObject
		{
			
			return cursorInstance;
		}
		
		private static function mouseDown(e:Event):void
		{
			if(cursorInstance&&cursorInstance.parent)
				MovieClip(cursorInstance).gotoAndPlay(2);
		}
		
		
		private static function mouseMoveHandler(event:MouseEvent):void
		{
			if (!cursorInstance) return;
			if(!cursorInstance.parent)return;
			
			if(showMouseCursor)
			{
				Mouse.show();
			}
			else
			{
				Mouse.hide();
			}
			if(isGameLayer(event.target as DisplayObject))
			{
				cursorInstance.visible=true;
				Mouse.hide();
			}
			else
			{
				cursorInstance.visible=false;
				Mouse.show();
			}
			cursorInstance.x = event.stageX;
			cursorInstance.y = event.stageY;
			event.updateAfterEvent();
		}

		private static function isGameLayer(target:DisplayObject):Boolean
		{
			var parent:Object;
			if(target is Sprite)
				parent=target;
			else
				parent=target.parent;
			while(parent)
			{
				if(parent ==gameLayer)
					return true;
				else
					parent=parent.parent;
			}
			return false;
		}
		
		private static var mouseIcon:Sprite
		private static var movFun:Function;
		public static function setMouseIcon(spr:Sprite):void
		{
		
			
			if(mouseIcon){
				cursorLayer.removeChild(mouseIcon);
			}
			if(movFun!=null)
			{
				cursorLayer.stage.removeEventListener(MouseEvent.MOUSE_MOVE,movFun);
				movFun=null;
			}				
			mouseIcon=spr;
			cursorLayer.addChild(mouseIcon);
			mouseIcon.x=cursorLayer.mouseX;
			mouseIcon.y=cursorLayer.mouseY;
			Mouse.hide();
			movFun=function(e:MouseEvent):void
			{
				Mouse.hide();
				mouseIcon.x=e.stageX;
				mouseIcon.y=e.stageY;
			}
			cursorLayer.stage.addEventListener(MouseEvent.MOUSE_MOVE,movFun);			
		}
		public static function removeMouseIcon():void
		{
			Mouse.show();
			if(mouseIcon)
			{
				cursorLayer.removeChild(mouseIcon);
				cursorLayer.stage.removeEventListener(MouseEvent.MOUSE_MOVE,movFun);
				movFun=null;
				mouseIcon=null;
			}
			
		}
	}
}