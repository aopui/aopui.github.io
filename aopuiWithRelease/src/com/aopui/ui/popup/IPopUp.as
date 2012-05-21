package  com.aopui.ui.popup
{
//	import mx.core.IFlexDisplayObject;
	
	public interface IPopUp
	{
		function open(window:Object, model:Boolean = true):void;
		
		function close():void;
		
		function closeAll():void;
	}
}