package client.list
{
	import client.ren.MyToggleListRender;
	
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.ui.ToggleList;
	
	public class MyToggleList extends ToggleList
	{
		public function MyToggleList()
		{
			MyToggleListRender
			super();
			xml=<layout  width="1000" height="500"  pageSize="50"
						direction="vertical"	
//						verticalGap="-20"
						eventListener={GroupEvent.GROUP_CLICK+",groupClick"}
						renderClass="client.ren.MyToggleListRender"/>;
		}
		public function groupClick(e:EventBase):void
		{
		
		}
		
	}
}