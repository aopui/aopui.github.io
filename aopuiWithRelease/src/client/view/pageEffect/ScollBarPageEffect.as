/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 19, 2010
* WUSHIHUAN
*/
package  client.view.pageEffect
{
	import client.asSkin.DefaultSkin;
	
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.effect.page.IPageEffect;
	import com.aopui.event.EventBase;
	import com.aopui.ui.BasicUI;
	import com.aopui.ui.Button;
	import com.aopui.ui.ContainBase;
	import com.aopui.ui.Panel;
	import com.aopui.ui.VBox;
	import com.aopui.ui.list.ListBase;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScollBarPageEffect extends Panel implements  IPageEffect
	{	
		DefaultSkin;
		private var _contain:ContainBase;
		private var bgMc:Sprite;
		private var thumb:Sprite;
		public function ScollBarPageEffect()
		{
			xml=<layout top="0" bottom="0" globalAlign="E">
				<!--
				<Button id="bg" skinClass="com.aopui.assets.verticalBarBg" top="0" bottom="0" width="12.2"/>
				-->
				   <Panel id="thumb" width="22"  eventListener={MouseEvent.MOUSE_DOWN+",onMouseDown,"+MouseEvent.MOUSE_OVER+",onMouseOver,"+MouseEvent.MOUSE_OUT+",onMouseOut"}>
					   <Button id="thumb_default" top="0" bottom="0" right="0" left="0"  skinClass="com.aopui.assets.verticalBarThumb"/>
					   <Button id="thumb_hover" top="0" bottom="0" right="0" left="0" visible="false" skinClass="com.aopui.assets.verticalBarThumb_hover"/>
				   </Panel>
				</layout>;
			this.addEventListener("scrollBarEvent",onScrolling);
		}
		public function onScrolling(e:EventBase):void
		{
			var w:Number=_contain.showAbleSpace.height-this.height;
			w*=e.message.num;
			_contain.showAbleSpace.y=-w;
		}
		
		
		public function onMouseOver(e:MouseEvent):void
		{
			$.thumb_default.visible=false;
			$.thumb_hover.visible=true;
		}
		
		public function onMouseOut(e:MouseEvent):void
		{
			$.thumb_default.visible=true;
			$.thumb_hover.visible=false;
		}
		
		public function getVerticalScrollBarH():Number
		{
			return 0;
		}
		public function getVerticalScrollBarW():Number
		{
			return 22;
		}
		public function getHorizonScrollBarW():Number
		{
			return 0;
		}
		public function getHorizonScrollBarH():Number
		{
			return 0;
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			oldY=this.mouseY;
			$.thumb.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			$.thumb.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		private var oldY:Number=0;
		public function onMouseMove(e:MouseEvent):void
		{
			var step:Number=1;
			if(oldY>this.mouseY)
				step=-1;
			$.thumb.y+=step*Math.abs(oldY-this.mouseY);
			if($.thumb.height+$.thumb.y>this.height)
				$.thumb.y=this.height-$.thumb.height;
			if($.thumb.y<0)
				$.thumb.y=0;
			oldY=this.mouseY;
			var num:Number=$.thumb.y/(this.height-$.thumb.height)
			this.dispatchEvent(EventBase.createEvent("scrollBarEvent",{num:num}));
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			$.thumb.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			$.thumb.stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		public function get contain():ContainBase
		{
			return _contain;
		}
		
		public function set contain(c:ContainBase):void
		{
			this._contain=c;
			this.parentui=c;
		}
		
		public function addPageBtns():void
		{
			
		}
		
		override public function layout():void
		{
			super.layout();
			$.thumb.visible=true;
//			$.bg.x=this.width/2-$.bg.width/2;
			$.thumb.x=this.width/2-$.thumb.width/2;
			$.thumb.height=_contain.height/_contain.showAbleSpace.height*_contain.height;
			
			if($.thumb.height>_contain.height)
				$.thumb.height=_contain.height;
			if($.thumb.height<20)
				$.thumb.height=20;
			$.thumb_default.height=$.thumb_hover.height=$.thumb.height;
			if($.thumb.height>=this.height)
				$.thumb.visible=false;
		}
		
		public function addNavigation():void
		{
			_contain.contentLayer.addChild(this);
		}
		
		public function remNavigation():void
		{
			if(_contain)
				this.parent.removeChild(this);
		}
	}
}