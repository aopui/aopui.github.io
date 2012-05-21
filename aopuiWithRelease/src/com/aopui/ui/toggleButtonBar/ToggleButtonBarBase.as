/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui.toggleButtonBar
{
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.ui.button.ButtonBase;
	import com.aopui.ui.buttonBar.ButtonBarBase;
	import com.aopui.ui.list.RenderBase;

	
	public class ToggleButtonBarBase extends ButtonBarBase
	{
		public var selected:RenderBase;
		private var _selectedIndex:int;
		
		public function ToggleButtonBarBase()
		{
			super();
			this.addEventListener(GroupEvent.GROUP_CLICK,_onGroupClick);
		}
		public function set selectedIndex(index:int):void
		{
			_selectedIndex=index;
			selectRender(selectedIndex);
			preselected=selected;
			selected=RenderBase(randers[selectedIndex]);
		}
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public var preselected:RenderBase
		private function _onGroupClick(e:EventBase):void
		{
			selectedIndex=e.message.index;
			selectRender(selectedIndex);
			
//			selected=ButtonBase(e.message.target);
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