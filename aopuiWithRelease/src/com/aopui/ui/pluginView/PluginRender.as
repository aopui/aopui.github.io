package com.aopui.ui.pluginView
{
	import flash.events.EventDispatcher;

	public class PluginRender extends EventDispatcher
	{
		public var renderContent:Object;
		public var $ui:Object={};
		public var $uic:Object={};
		public var index:int=-1;
		public function PluginRender(renderContent:Object,index:int)
		{
			this.index=index
			this.renderContent=renderContent;
			PluginContentSearcher.execute(renderContent,this);
			onInit(null);
		}
		protected function onInit(e:Object):void
		{
			
		}
		protected var _data:Object;
		public function set data(value:Object):void
		{
			_data=value;
		}
		
		public function addRenerListener(eventType:String,uiType:String,callBack:Function):void
		{
			$ui[uiType].addEventListener(eventType,callBack);
		}
	}
}