/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui
{
	import com.aopui.ui.button.ButtonBase;
	
	
	/**
	 *Button
	 *特性 <br>
	 * 1.可以赋予皮肤<br>
	 * 			1.1 皮肤制作规则
	 * 					
	 * 2.可以显示文字 并设置字体
	 * 		2.1 设置文本 text="文本"
	 * 		2.2 设置字体 font="注册过的字体名称";
	 * 3.自动布局 
	 * 			3.1 没有指定宽，高  
	 * 					3.1.1 skin的尺寸大于 文字的尺寸 那么按钮的大小就 是skin的大小
	 * 					3.1.2 skin的尺寸小于 文字的尺寸 按钮的 宽=文字宽+4；高=文字高+4
	 * 			3.2 指定了宽，高
	 * 					3.2.1 尺寸= 指定的宽 高 ，当文字大于指定的尺寸时候将显示部分文字
	 *
	 * 4.默认大小 130*45;
	 **/
	public class Button extends ButtonBase
	{
		public function Button()
		{
			super();
		}
		override public function set data(value:Object):void
		{
			super.data=value;
		}
	}
}