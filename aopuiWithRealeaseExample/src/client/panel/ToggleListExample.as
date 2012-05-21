package client.panel
{
	import client.list.MyToggleList;
	
	import com.aopui.ui.dynamicImg.BaseDynamicImg;
	import com.aopui.ui.list.RenderBase;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	public class ToggleListExample extends RenderBase
	{
		
		public function ToggleListExample()
		{
			MyToggleList
			super();
			xml=<layout trbl="0,0,0,0" state="toggleList">
						<MyToggleList path="client.list" id="toggleList"/>
					</layout>
				$.toggleList.data=[{},{},{},{},{},{},{},{},{},{}];
		}
	}
}