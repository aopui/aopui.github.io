package client.mainui.view.list
{
	import client.mainui.view.render.ItemListRender;
	
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.ui.ToggleList;

	public class ItemList  extends ToggleList
	{
		ItemListRender;
		public static var dispatcher:Function;
		public function ItemList()
		{
			super();
			var x:XML=<layout width="718" state="edit"  marginTop="10" height="110" marginLeft="30" horizonGap="-26"
										eventListener={GroupEvent.GROUP_CLICK+",groupClick"}
			skinClass="RoundCornerPanel" 
			renderClass="client.mainui.view.render.ItemListRender"/>;
			this.xml=x;
		}
		
		public function groupClick(e:EventBase):void{
			try{
//				dispatcher(
//					AllPowerfulMessage.createRequest("user.get_scene",{uid:e.message.data.uid})
//				);
			}catch(o:Object)
			{
				
			}
		}
	}
}