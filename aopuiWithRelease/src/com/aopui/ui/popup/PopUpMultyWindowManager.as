package  com.aopui.ui.popup
{
	import flash.display.DisplayObject;
	
//	import mx.core.Application;
//	import mx.core.IUIComponent;
//	import mx.managers.PopUpManager;
	
	
	public class PopUpMultyWindowManager implements IPopUp
	{
		public function PopUpMultyWindowManager()
		{
		}
		
		private static var instance:PopUpMultyWindowManager;
		
		public static function Instance():PopUpMultyWindowManager
		{
			if (instance == null)
			{
				instance = new PopUpMultyWindowManager();
			}
			
			return instance;
		}
						
		private var array:Array = new Array();		//窗口集合		
				
	 	public function open(window:Object, model:Boolean = false):void		//目前只用到2个参数
		{
//			array.push({'win':window,'mod':model});							
//			var app:DisplayObject = Application.application as DisplayObject;			
//			PopUpManager.addPopUp(window, app, model);
//			PopUpManager.centerPopUp(window);			
		}
		
		public function close():void
		{
			if (array.length == 0)
			{
				return;
			}
			
			var obj:Object = array.pop(); 			
//			PopUpManager.removePopUp(obj['win'] as IFlexDisplayObject);			
		}
		
		public function closeAll():void
		{
			var len:int = array.length;
			while(len > 0)
			{
				close();
				len--;
			}
		}
	}
}