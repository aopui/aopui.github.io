/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui
{
	import com.aopui.ui.box.BoxBase;
	
	import flash.display.DisplayObject;
	
	public class HBox extends BoxBase
	{
		public function HBox()
		{
			super();
		}
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			randers.push(child);
			this.invalidate();
			return child;
		}
		
		override public function layout():void
		{			
			this.HLayout();
			super.layout();
		}
		
		override public function set data(d:Object):void
		{
			super.data=d;
			this.createRender();
			this.invalidate();
		}
	 	
	}
}