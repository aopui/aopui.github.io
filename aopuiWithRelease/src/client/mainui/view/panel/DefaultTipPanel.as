////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 4, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package client.mainui.view.panel
{
	import com.aopui.core.IToolTipPanel;
	import com.aopui.ui.Panel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	public class DefaultTipPanel extends Panel implements IToolTipPanel
	{
		
		public function DefaultTipPanel()
		{
			super();
			var x:XML=<layout>
						<Label id="tip"/>
					  </layout>
			this.xml=x;
		}
		
		private var _data:Object;
		public function set data(d:Object):void
		{
			_data=d;
			if(!d)
				return;
			setValue("tip","text",d);
		}
		public function get data():Object
		{
			return _data;
		}
	}
}