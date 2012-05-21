package client.mainui.view.panel
{
	import client.mainui.view.render.ItemListRender;
	
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.model.Category;
	import com.aopui.ui.Panel;
	
	import flash.media.Video;
	
	public class ItemListPanel extends Panel
	{
		ItemListRender;
		private var d:Category;
		public function ItemListPanel()
		{
			super();
				var x:XML=<layout width="718" height="150" skinClass="RoundCornerPanel"  state="edit">
								<ToggleButtonBar id="bar" x="30" y="5" selectedIndex="0" 
										buttonSkinClass="ButtonSkin" renderClass="Button"
										eventListener={GroupEvent.GROUP_CLICK+",onbarClick"}/>
								<List id="list" width="718" height="110" y="35" marginLeft="35" horizonGap="-32"
									renderClass="client.mainui.view.render.ItemListRender"
									pageEffect="com.aopui.effect.page.ListPageEffect"
									eventListener={GroupEvent.GROUP_CLICK+",groupClick"}/>				
						  </layout>
			this.xml=x;
			
		}
		public function set data(d:Object):void
		{
			this.d=Category(d);
			var data:Array=[];
			for each(var c:Category in this.d.categories)
			{
				data.push({txt:c.id});
			}
			$.bar.data=data;
			$.bar.selectedIndex=0;
			showItems();
		}
		private function showItems():void
		{
			$.list.data=d.categories[$.bar.selectedIndex].items;		
		}
		public function onbarClick(e:EventBase):void
		{
//			trace(e);
			showItems();
		}
		
		public function groupClick(e:EventBase):void{
			try{
				model.draggingItem=e.message;
			}catch(o:Object)
			{
				
			}
		}
	}
}