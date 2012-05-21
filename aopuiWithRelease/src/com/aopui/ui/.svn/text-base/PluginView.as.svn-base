package com.aopui.ui
{
	import com.aopui.ui.pluginView.PluginContentSearcher;
	import com.aopui.ui.pluginView.PluginList;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;

	public class PluginView extends Sprite// BasicUI
	{
		protected var basicElement:Sprite;
		public function PluginView(basicElement:Sprite)
		{
			this.basicElement=basicElement
			this.addChild(this.basicElement);
		}
		private var _listClass:Class;
		public function set listClass(value:Class):void
		{
			_listClass=value;
		}
		public var $ui:Object={};
		public var $uic:Object={};
		public function initUI():void
		{
			if(basicElement.hasOwnProperty("closeBtn"))
			{
				handleElementFunction("closeBtn");
			}
			PluginContentSearcher.execute(basicElement,this);
		}
		
		public function $mc(name:String):Object
		{
			if(basicElement.hasOwnProperty(name))
			{
				return basicElement[name];
			}
			return null;
		}
		
		public function handleElementFunction(name:String):void
		{
			switch(name)
			{
				case "closeBtn":
					if(!basicElement[name].hasEventListener(MouseEvent.CLICK))
						basicElement[name].addEventListener(MouseEvent.CLICK,onClose);
					break;
				case "c":
					break;
				default:
					break;
			}
		}
		
		public function onClose(e:Event):void
		{
			
		}		
		
//		override public function addChild(child:DisplayObject):DisplayObject
//		{
//			return defaultAddChild(child);
//		}
//		
//		override public function get width():Number
//		{
//			return $width;
//		}
//		
//		override public function get height():Number
//		{
//			return $height;
//		}
//		
//		override public function set width(value:Number):void
//		{
//			$width=value;
//		}
//		
//		override public function set height(value:Number):void
//		{
//			$height=value;
//		}
	}
}