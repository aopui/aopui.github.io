/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package  com.aopui.ui.buttonBar
{
	import com.aopui.ui.list.ListBase;
	import com.aopui.ui.list.RenderBase;
	
	import flash.display.DisplayObject;
	

	public class ButtonBarBase extends ListBase
	{
		private var _buttonSkinClass:Class;
		public function ButtonBarBase()
		{
			super();			
			this.marginTop=2;
			this.marginLeft=2;
			this.horizonGap=2;
			this.navigation=false;
			this.listType=listTypes[1];
			this.needMask=false;
		}
		
		public function get buttonSkinClass():Class
		{
			return _buttonSkinClass;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			addRenderChild(child as RenderBase);
			randers.push(child);
			RenderBase(child).index=randers.length-1;
			this.invalidate();
			return child;
		}

		public function set buttonSkinClass(value:Class):void
		{
			_buttonSkinClass = value;
			randerSkinClass=value;
		}
		
		override public function layout():void
		{
			this.HLayout();
//			this.rectW=this.showAbleSpace.width;
//			this.rectH=this.showAbleSpace.height;
			super.layout();
		}

		override public function set data(d:Object):void
		{
			super.data=d;
			this.pageSize=d.length;
			this.removeAllRenderChild();
			this.createRender();
			this.invalidate();
			
			
		}
	}
}