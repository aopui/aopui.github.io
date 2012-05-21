////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 8, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package client.mainui.view.otherPanel
{
	import com.aopui.admiral.LayoutAdmiral;
	import com.aopui.admiral.PopupAdmiral;
	import com.aopui.ui.Panel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class OtherPanel extends Panel
	{
		public function OtherPanel()
		{
			super();
			var x:XML=<Layout right="1">
							<HBox>
								<Button id="extendFishBtn"
										skinClass="ExtendFishBtnSkin"
										toolTip="扩展水槽"
										eventListener={MouseEvent.CLICK+",extendFishBtnClick"}/>
								<VBox>
									<Button id="refreshBtn" skinClass="RefreshBtnSkin" toolTip="刷新" 
											eventListener={MouseEvent.CLICK+",refreshBtnClick"}/>
									<Button id="personalSetBtn" skinClass="PersonalSettingSkin" toolTip="设置" 
											eventListener={MouseEvent.CLICK+",personalSetBtnClick"}/>
									<Button id="lockDecBtn" skinClass="LockDecBtnSkin" toolTip="冻结装饰"
											eventListener={MouseEvent.CLICK+",lockDecBtnClick"}/>
								</VBox>
							</HBox>
						</Layout>
				this.xml=x;
		}
		
		public function refreshBtnClick(e:Event):void
		{
			trace("刷新");
			PopupAdmiral.alert({data:{txt:"刷新--------------------fdsafdsafdsa呵呵"}});
			
		}
		
		public function personalSetBtnClick(e:Event):void
		{
			trace("个人设置");
			LayoutAdmiral.changeSence();
		}
		
		public function lockDecBtnClick(e:Event):void
		{
			//冻结装饰
		}
		
		public function extendFishBtnClick(e:Event):void
		{
			//扩展鱼塘
		}
	}
}