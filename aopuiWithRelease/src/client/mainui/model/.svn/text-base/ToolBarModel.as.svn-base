/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-9-10
* Michael
*/
package client.mainui.model
{
	import com.aopui.admiral.CursorAdmiral;
	import com.aopui.admiral.PopupAdmiral;
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.Marshal;
	
	import flash.display.DisplayObject;
	
	public class ToolBarModel
	{
		[Inject]
		public var marshal:Marshal;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		private var _showingDrag:Boolean;
		private var _currentToolId:String;
		private var _currentToolView:DisplayObject;
		
		public function ToolBarModel()
		{
		}
		
		public function getCurrentToolName():String
		{
			return _currentToolId;
		}
		
		public function setCurrentToolName(value:String):void
		{
			_currentToolId=value;
		}
		
		public function getCurrentToolView():DisplayObject
		{
			return 	CursorAdmiral.getCursorInstance();
		}
		
		public function showDragCursor(param:Object):void
		{
			_showingDrag = true;
			CursorAdmiral.setCursor({cursor:getUI("CursorDrag"),x:param.x,y:param.y});
		}
		
		public function hideDragCursor(param:Object):void
		{
			_showingDrag = false;
			CursorAdmiral.undo({x:param.x,y:param.y});
		}
		
		private function getUI(name:String):Class
		{
			return ResourceAdmiral.getUI(name) as Class;
		}
	}
}