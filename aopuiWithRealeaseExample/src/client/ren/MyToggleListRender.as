package client.ren
{
	import com.aopui.ui.dynamicImg.BaseDynamicImg;
	import com.aopui.ui.list.RenderBase;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	public class MyToggleListRender extends RenderBase
	{
		
		public function MyToggleListRender()
		{
			xml=<layout skinClass="buttonSkin" mouseChildren="false"  width="400">
								<Label id="label" globalAlign="C" font="font1"/>
							</layout>
		}
		
		override public function layout():void
		{
			super.layout();
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			$.label.text="测试测试";
		}
	}
}