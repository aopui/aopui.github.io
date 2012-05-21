package client.mainui.view.panel
{
	import com.aopui.ui.BasicUI;
	
	import flash.display.Sprite;
	
	public class BottomPanel extends BasicUI
	{
		public function BottomPanel()
		{
			super();
			this.globalAlign="S";
		}
		override public function set width(value:Number):void
		{
			super.width=value;
		}
		
		override public function set height(value:Number):void
		{
			super.height=value;
		}
		override public function layout():void
		{
			for(var i:int=0;i<numChildren;i++)
			{
				var o:Object=this.getChildAt(i)
				trace(o);
				trace(o.width);
				trace(o.height);
				if(o is BasicUI)
				{
					trace("isB");
					trace(o.$width);
					trace(o.$height);
				}
			}
			super.layout();
		}
	
	}
}