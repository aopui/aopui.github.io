package com.aopui.ui.pluginView
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class PluginList extends EventDispatcher
	{
		private var listContent:Object
		private var renderCount:int;
		protected var _data:Object
		private var startIndex:int=0;
		
		public var $ui:Object={};
		public var $uic:Object={};
		public function PluginList(listContent:Object,renClass:Class)
		{
			$ui.renders=[];
			$uic.renClass=renClass;
			this.listContent=listContent;
			renderCount=listContent.renContent.numChildren;
			if(listContent.hasOwnProperty("leftPageBtn"))
			{
				listContent["leftPageBtn"].addEventListener(MouseEvent.CLICK,leftPage);
			}
			if(listContent.hasOwnProperty("rightPageBtn"))
			{
				listContent["rightPageBtn"].addEventListener(MouseEvent.CLICK,rightPage);
			}
			for(var i:int=0;i<renderCount;i++)
			{
				$ui.renders.push(
									new $uic.renClass(listContent.renContent["ren"+i],i)
								 );
			}
		}
		
		public function leftPage(e:Object=null):void
		{
			if(startIndex<1)
				return;
			startIndex-=renderCount;
			refreshPage();
		}
		
		
		public function rightPage(e:Object=null):void
		{
			if(!_data)
				return;
			if(startIndex>=_data.length-renderCount)
				return;
			startIndex+=renderCount;
			refreshPage();
		}
		
		public function set data(value:Object):void
		{
			this._data=value;
			startIndex=0;
			refreshPage();
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		private var currentData:Array=[];
		private function refreshPage():void
		{  
			if(!_data)
				return;
			currentData=[];
			for(var i:int=startIndex;i<startIndex+renderCount;i++)
			{
				if(i>_data.length-1)
					currentData.push(null);
				else
					currentData.push(_data[i]);
			}
			for(var j:int=0;j<renderCount;j++)
			{
				$ui.renders[j].data=currentData[j];
			}
		}
		
		public function addRenderListener(eventType:String,callBack:Function):void
		{
			for each(var render:Object in $ui.renders)
			{
				render.addEventListener(eventType,callBack);
			}
		}
		
	}
}