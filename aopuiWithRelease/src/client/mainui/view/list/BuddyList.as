package client.mainui.view.list
{
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.ui.List;
	import com.aopui.ui.ToggleList;
	
	import flash.events.Event;
	import client.mainui.view.render.BuddyListRender;

	public class BuddyList extends ToggleList
	{
		BuddyListRender;
		public static var dispatcher:Function;
		public function BuddyList()
		{
			super();
			//globalAlign
			var x:XML=<layout y="30" state="play,friend" width="718"  marginTop="30" height="110" marginLeft="30" horizonGap="-28" 
							eventListener={GroupEvent.GROUP_CLICK+",groupClick"}
							gameuiType="bottomPanel"
							skinClass="RoundCornerPanel" 
							renderClass="client.mainui.view.render.BuddyListRender"/>;
			this.xml=x;
		}
		
		override public function set data(d:Object):void
		{
			super.data = d;
		}
		
		
		public function groupClick(e:EventBase):void{
			try{
				dispatcher(
						AllPowerfulMessage.createRequest("user.get_scene",{uid:e.message.data.uid})
						);
			}catch(o:Object)
			{
			
			}
		}

		
	}
}