package com.aopui.ui.popup
{
//	import mx.core.IFlexDisplayObject;
	
	public class PopUpWindowManager
	{
		public function PopUpWindowManager()
		{
		}
		
		private static var pop:IPopUp;		
		
//		public static function open(window:IFlexDisplayObject, model:Boolean = false, popUpType:String = PopUpType.MultyWindow):void
//		{
//			/**
//			 * 临时存储弹出窗体的方式  然后关闭直接用close(this)
//			 * 
//			 * 在这里没有加入CLOSE方法或是控制如何关闭窗口的参数
//			 * 
//			 * 可以先colseAll 再open 提供更灵活的方式
//			 * */		
//			window.name = popUpType;		
//			
//			getImpl(popUpType).open(window, model);
//		}
		
//		public static function close(window:IFlexDisplayObject):void
//		{
//			getImpl(window.name).close();
//		}
//		
		/**
		 * 同时关闭的大多数为 多级窗口 
		 * 
		 * 极特殊情况下同时关闭两种不同风格的窗口 则调用2次
		 * */
		public static function closeAll(popUpType:String = PopUpType.MultyWindow):void
		{
			getImpl(popUpType).closeAll();
		}
		
		private static function getImpl(popUpType:String):IPopUp
		{
			switch(popUpType)	/**不必要用反射*/
			{
				case PopUpType.NextWindow:
				{
					pop = PopUpNextWindowManager.Instance();
					break;
				}
				case PopUpType.MultyWindow:
				{
					pop = PopUpMultyWindowManager.Instance();
					break;
				}
			}
			
			return pop;
		}
	}
}