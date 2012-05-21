package  com.aopui.ui.popup
{
	import flash.display.DisplayObject;
	
//	import mx.core.Application;
//	import mx.core.IFlexDisplayObject;
//	import mx.core.IUIComponent;
//	import mx.managers.PopUpManager;
	
	public class PopUpNextWindowManager implements IPopUp
	{
		public function PopUpNextWindowManager()
		{
		}
		
		private static var instance:PopUpNextWindowManager;
		
		public static function Instance():PopUpNextWindowManager
		{
			if (instance == null)
			{
				instance = new PopUpNextWindowManager();
			}
			
			return instance;
		}
				
		private var array:Array = new Array();		//窗口集合
		
		private var isOpen:Boolean = false;			//是否有打开的窗口 	  因为要一个个弹出
		
	    private var currentIndex:int = 0;			//当前窗口索引
		
		
		public function open(window:Object, model:Boolean = false):void		//目前只用到2个参数
		{
			array.push({'win':window,'mod':model});
			
			next();
		}
		
		public function close():void
		{
			var obj:Object = array.shift();
			
//			PopUpManager.removePopUp(obj['win'] as IFlexDisplayObject);
			
			isOpen = false;
			
			next();
		}
		
		public function closeAll():void
		{
			/**
			 * 下一个窗体  采取模态方式
			 * 
			 * do somthing
			 * */
		}
		
		private function next():void
		{
			
			if (!isDone())
			{
				return;	
			}				
							
			if (!isOpen)
			{					
//				var app:DisplayObject = Application.application as DisplayObject;
//				var win:IFlexDisplayObject = array[currentIndex]['win'] as IFlexDisplayObject;
//				PopUpManager.addPopUp(win, app, array[currentIndex]['mod']);
//				PopUpManager.centerPopUp(win);
//				isOpen = true;
			}
			
		}
		
		private function isDone():Boolean
		{
			return array.length > 0 ? true : false;
		}
	}
}