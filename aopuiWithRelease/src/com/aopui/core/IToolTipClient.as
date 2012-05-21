package com.aopui.core
{
	public interface IToolTipClient
	{
		function set toolTip(value:Object):void;
		function get toolTip():Object;
		function set toolTipClass(value:String):void;
		function get toolTipClass():String;
		function set toolTipType(value:String):void;
		function get toolTipType():String;
		function get offsetx():Number;
		function get offsety():Number;
	}
}