////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 3, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package client.mainui.view.window
{
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.model.Category;
	import com.aopui.ui.Window;
	import com.aopui.ui.dynamicImg.BaseDynamicImg;

	public class PackWindow extends Window
	{
		
		public static var dispatcher:Function;
		public function PackWindow()
		{
			super();
			var x:XML=<layout height="480" skinClass="DefaultWindow" width="480">
						<VBox x="35" y="40" width="400" height="400">
							<ToggleButtonBar id="mainBar"
 								scaleX="0.85" scaleY="0.85"
								selectedIndex="0" 
								buttonSkinClass="TabButtonSkin" 
								renderClass="Button"
								height="30" 
								font="font2"
								eventListener={GroupEvent.GROUP_CLICK+",onMainBarClick"}
								/>
					
							<TileList id="list"
								renderClass="com.aopui.mainui.view.pack.PackRender"
								tileWidth="75"
								tileHeight="90"
								verticalGap="20"
								navigationPreHeight="300"
								navigationHGap="10"
								eventListener={GroupEvent.GROUP_CLICK+",onListItemClick"}
							/>				
						</VBox>
					  </layout>;			
			this.xml=x;
			
			/*
			
			<ToggleButtonBar id="subBar"
			scaleX="0.8" scaleY="0.8" 
			selectedIndex="0" 
			buttonSkinClass="TabButtonSkin" 
			renderClass="Button"
			height="30"
			/>
			*/
		}
		private var _data:Object;
		private var _orderdData:Object={};
		private var _tagString:Array=[];
		
		public function onListItemClick(e:EventBase):void
		{
			var category:String=_data[$.mainBar.selectedIndex].id;
			dispatcher(
						AllPowerfulMessage.createRequest("scene.add_fish",{category:category,num:"1",good_type:"",name:e.message.data.nameid})
						);
		}
		
		
		override public function layout():void
		{
			super.layout();
			this.closeBtn.x=this.width-53;
			this.closeBtn.y=11;			
		}
		
		public function set data(value:Object):void
		{
			var cs:Array=[];
			
			for each(var c:Category in value)
			{
				if(c.used)
				{
					cs.push(c);
					_tagString.push({txt:ResourceAdmiral.getString(c.id)});
				}					
			}
			$.mainBar.data=_tagString;			
			_data= cs;
			$.mainBar.selectedIndex=0;
			setTagData(0);
			setListData(0);
		}
		private function setTagData(index:int):void
		{
			var tmptag:Array=[];			
			for each(var c:Category in _data[index].categories)
			{
				if(c.used)
				{
					tmptag.push({txt:ResourceAdmiral.getString(c.id)});
				}
			}
		}
		
		private var currentCategories:Array=[]
		private function setListData(index:int):void
		{
			currentCategories=[];
			var c:Category=_data[$.mainBar.selectedIndex];
			
			if($.mainBar.selectedIndex==3)
			{
				$.list.renderParam={animationType:BaseDynamicImg.FrameType}
				
			}else
			{
				$.list.renderParam={animationType:BaseDynamicImg.LayerType,frameRate:4}
			}
			
			if(c.categories.length>0)
			{
				for each(var subc:Category in c.categories)
				{
					if(subc.used)
						currentCategories.push(subc);
				}
				$.list.data=currentCategories[index].items;
			}
			else
			{
				$.list.data=c.items;
			}
		}
		
		public function onMainBarClick(e:EventBase):void
		{
			var index:int=e.message.index;
			setTagData(index);
			setListData(0);			
		}
		
		public function get data():Object
		{
			return _data;
		}
		
	}
}