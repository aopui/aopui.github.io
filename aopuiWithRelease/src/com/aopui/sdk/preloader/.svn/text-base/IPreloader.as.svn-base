/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-8-24
* Michael
*/
package com.aopui.sdk.preloader
{
	import flash.display.Sprite;
	import flash.display.Stage;

	public interface IPreloader
	{
		/**
		 * 显示下载进度
		 */
		function showProgress( progress:Number ):void;
		
		/**
		 * 显示提示文字
		 */
		function showPromptLabel( text:String ):void;

		/**
		 * 移除预加载页面
		 */
		function removePreloader():void;
		
		/**
		 * 获取舞台的引用，只此一个地方能获取，很关键
		 */
		function get stage():Stage;
		
		
		function get sceneLayer():Sprite
			
		function get loaderLayer():Sprite;
	}
}