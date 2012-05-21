/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui.window
{
	import com.aopui.admiral.PopupAdmiral;
	import com.aopui.event.EventBase;
	import com.aopui.event.WindowEvent;
	import com.aopui.ui.Button;
	import com.aopui.ui.ContainBase;
	import com.aopui.ui.Window;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class WindowBase extends ContainBase
	{
		protected var closeBtn:Button=new Button();
		
		public function WindowBase()
		{
			this.navigation=false;
			this.skinClass=getUI("ShopBg");
			closeBtn.skinClass=getUI("CloseBtnSkin");
			addChild(closeBtn);
			closeBtn.mouseChildren=false;
			this.closeBtn.addEventListener(MouseEvent.CLICK,onCloseBtnClick);
		}
		public function set closeBtnPoint(p:String):void
		{if(!p)return;
			var a:Array=p.split(",");
			if(a.length<2)return;
			closeBtn.x=Number(a[0]);
			closeBtn.y=Number(a[1]);
		}
		private function onCloseBtnClick(e:Event):void
		{
			onClose();
			this.dispatchEvent(EventBase.createEvent(WindowEvent.WINDOW_CLOSE));
			this.closeBtn.removeEventListener(MouseEvent.CLICK,onCloseBtnClick);
		}
		
		override public function layout():void
		{
			this.closeBtn.x=this.width-31.6;
			this.closeBtn.y=11;
		}
		
		private function onClose():void
		{
			close();
			//this.parent.removeChild(this);
		}
		public function close():void
		{
			PopupAdmiral.close();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return this.containAddChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return this.removeChild(child);
		}
		
		
		
	}
}