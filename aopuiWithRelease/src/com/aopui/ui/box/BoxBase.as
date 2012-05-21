/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui.box
{
	import com.aopui.ui.AreaField;
	import com.aopui.ui.VBox;
	import com.aopui.ui.list.ListBase;
	
	import flash.display.DisplayObject;
	import flash.text.engine.RenderingMode;

	public class BoxBase extends ListBase
	{
		private var _autoWidth:Boolean=true;
		
		
		public function BoxBase()
		{
			super();
			this.navigation=false;
			this.needMask=false;
			this.listType=listTypes[1];
		}
		
		override public function set autoWidth(b:Boolean):void
		{
			_autoWidth=b;
		}
		override public function get autoWidth():Boolean
		{
			return _autoWidth;
		}
		
		
		
		override public function createRender():void
		{
			for(var i:int=0;i<data.length;i++)
			{
				if(!(data[i] is DisplayObject))continue;
				this.addChild(DisplayObject(data[i]));
				randers.push(data[i]);
				if(this is VBox&&this.width!=0)
					data[i].width=this.width-this.marginLeft*2;
			}
		}
		
		
		
//		override protected function listen():void
//		{
//			
//		}
		
		
		override public function set width(value:Number):void
		{
			super.width=value;
			
			if(this is VBox)
			{
				if(autoWidth)
					return;
				for(var i:int=0;i<randers.length;i++)
				{
					randers[i].width=value-this.marginLeft*2;;
				}
			}
		}
	}
}