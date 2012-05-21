/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui
{
	import com.aopui.ui.box.BoxBase;
	
	import flash.display.DisplayObject;
	
	public class VBox extends BoxBase
	{
		public function VBox()
		{
			super();			
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			
			randers.push(child);
			if(!this.autoWidth)
				child.width=this.width;
			super.addChild(child);
			if(_bgInstance)
			{
				_bgInstance.width=width;
				_bgInstance.height=height;
			}
			this.invalidate();
			return child;
		}
		
		override public function set data(d:Object):void
		{
			super.data=d;
			this.createRender();
			this.invalidate();
		}
		
		override public function layout():void
		{
			this.VLayout();
			super.layout();
		}
	}
}