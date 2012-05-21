/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.event
{
	import flash.events.Event;

	public class EventBase extends Event
	{
		public var message:Object
		public function EventBase(type:String,data:Object=null,bubbles:Boolean=false,cancelable:Boolean=false)
		{
			this.message=data;
			super(type,bubbles,cancelable);
		}
		
		public static function createEvent(type:String,data:Object=null,bubbles:Boolean=false,cancelable:Boolean=false)
			:EventBase
		{
			return new EventBase(type,data,bubbles,cancelable);
		}
	}
}