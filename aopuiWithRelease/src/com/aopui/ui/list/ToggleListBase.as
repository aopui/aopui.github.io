////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 5, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.ui.list
{
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.ui.List;

	public class ToggleListBase extends List
	{
		public var selected:RenderBase;
		private var _selectedIndex:int;
		public function ToggleListBase()
		{
			needMask=true;
			super();
			this.addEventListener(GroupEvent.GROUP_CLICK,_onGroupClick);
		}
		
		public function set selectedIndex(index:int):void
		{
			_selectedIndex=index;
			selectRender(selectedIndex);
			selected=RenderBase(randers[selectedIndex]);
		}
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		private function _onGroupClick(e:EventBase):void
		{
			selectedIndex=e.message.index;
			selectRender(selectedIndex);
			selected=RenderBase(e.message.target);
		}
		
		protected function selectRender(index:int):void
		{
			for each(var b:RenderBase in this.randers)
			{
				if(!(b is RenderBase))
					return;
				if(b.index==index)
				{
					b.selected=true;
				}
				else
				{
					b.selected=false;
				}
			}
		}
	}
}