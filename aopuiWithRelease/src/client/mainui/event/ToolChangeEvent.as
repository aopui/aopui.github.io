/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-9-8
* Michael
*/
package client.mainui.event
{
	import flash.events.Event;
	
	public class ToolChangeEvent extends Event
	{
		public static const TOOL_CHANGE:String = "toolChange";
		
		public var toolId:String;
		
		public function ToolChangeEvent(type:String, toolId:String)
		{
			super(type);
			this.toolId = toolId;
		}
	}
}