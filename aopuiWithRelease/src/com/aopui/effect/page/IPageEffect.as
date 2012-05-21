/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 19, 2010
* WUSHIHUAN
*/
package com.aopui.effect.page
{
	import com.aopui.ui.ContainBase;
	import com.aopui.ui.list.ListBase;
	
	import flash.display.Sprite;

	public interface IPageEffect
	{	
		function get contain():ContainBase;
		function set contain(c:ContainBase):void;
		function addNavigation():void
		function remNavigation():void;
		function layout():void;
//		function pre1():void;		
//		function next1():void;		
//		function first():void;	
//		function last():void;
		function getVerticalScrollBarH():Number
		function getVerticalScrollBarW():Number
		function getHorizonScrollBarW():Number;
		function getHorizonScrollBarH():Number;
		
	}
}