package com.aopui.ui.pluginView
{
	import com.aopui.event.EventBase;
	import com.aopui.ui.PluginView;
	
	import flash.display.Sprite;

	public class PluginContentSearcher
	{
		public function PluginContentSearcher()
		{
		}
		public static function execute(basicElement:Object,p:Object):void
		{
			if(basicElement.hasOwnProperty("listContent"))
			{
				p.$ui.listContent=new p.$uic.listContent(basicElement["listContent"]);
			}
			
			if(basicElement.hasOwnProperty("numPanel"))
			{			
				p.$ui.numPanel=new PluginNumPanel(basicElement["numPanel"]);
			}
			
			if(basicElement.hasOwnProperty("sliderContent"))
			{
				p.$ui.sliderContent=new PluginSlider(basicElement["sliderContent"]);
			}
		}
	}
}