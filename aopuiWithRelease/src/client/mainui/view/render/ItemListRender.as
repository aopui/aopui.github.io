package client.mainui.view.render
{
	import com.aopui.ui.list.RenderBase;

	public class ItemListRender  extends RenderBase
	{
		public function ItemListRender()
		{
			var x:XML=<layout skinClass="ItemRenderBg" width="90" height="100" mouseChildren="false">
										<DynamicImg id="img" 
													imgHeight="80"
													imgWidth="80" 
													x="5" y="10" 
													roundCorner="true"
													/>
								  </layout>
			this.xml=x;
		}
		override public function set data(d:Object):void
		{
			super.data=d;
			$.img.source=getUI(d.otherProperty.className);
			
		}
	}
}