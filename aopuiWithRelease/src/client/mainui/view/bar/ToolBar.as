/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-9-8
* Michael
*/
package client.mainui.view.bar
{
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import client.mainui.event.ToolChangeEvent;
	import com.aopui.ui.Button;
	import com.aopui.ui.ButtonBar;
	import com.aopui.ui.Panel;
	import com.aopui.ui.ToggleButtonBar;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	public class ToolBar extends Panel
	{
		public function ToolBar()
		{
			
			/*
			toggleButtonBar.data=[
			{skin:getUI("OpArrowBtn"),cursor:"non",cmd:"default"},
			{skin:getUI("OpFeedBtn"),cursor:getUI("CursorFeed"),cmd:"feed"},
			{skin:getUI("OpWarmBtn"),cursor:getUI("CursorWarm"),cmd:"warm"},
			{skin:getUI("OpPickBtn"),cursor:getUI("CursorPick"),cmd:"pick"},
			{skin:getUI("OpPackBtn"),cmd:"pack"}
			]; 
			var x:XML=<layout globalAlign="S,Y-100,X-100">
			<ButtonBar id="toolBar" renderClass="Button" horizonGap="30" eventListener={GroupEvent.GROUP_CLICK+",onBarClick"}>
			<Button  skinClass="OpArrowBtn" cursor="non" cmd="arrow" toolTip="箭头"/>
			<Button  skinClass="OpFeedBtn" cursor="CursorFeed" cmd="feed" toolTip="喂食"/>
			<Button  skinClass="OpWarmBtn" cursor="CursorWarm" cmd="warm" toolTip="融化"/>
			<Button  skinClass="OpPickBtn" cursor="CursorPick" cmd="pick" toolTip="捞鱼"/>
			<Button  skinClass="OpPackBtn"  cmd="pack" toolTip="包裹"/>
			<Button  skinClass="OpShopBtn" cmd="shop" toolTip="商店"/>
			</ButtonBar>
			</layout>;
			this.xml=x;
			*/
			super();
			var x:XML=<layout y="-20" x="500">
						<ButtonBar id="toolBar" renderClass="Button" state="edit" horizonGap="10" eventListener={GroupEvent.GROUP_CLICK+",onBarClick"}>
							<Button  skinClass="MouseIcon" cursor="non" cmd="cursor" toolTip="指针"/>
							<Button  skinClass="MoveIcon" cursor="MoveCursor" cmd="move" toolTip="移动"/>
							<Button  skinClass="RotateIcon" cursor="RotateCursor" cmd="rotate" toolTip="旋转"/>
							<Button  skinClass="RecoverIcon" cursor="RecoverCursor" cmd="recover" toolTip="回收"/>
							<Button  skinClass="SellIcon" cursor="SellCursor" cmd="sell" toolTip="卖出"/>
						</ButtonBar>
					  </layout>;
			this.xml=x;
		}
		
		public function onBarClick(e:EventBase):void
		{	var toolId:String=e.message.target.cmd;
			dispatchEvent(new ToolChangeEvent(ToolChangeEvent.TOOL_CHANGE, toolId));
		}
	}
}