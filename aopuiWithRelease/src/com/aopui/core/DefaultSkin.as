package com.aopui.core
{
	import com.aopui.model.GlobalModel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class DefaultSkin extends Sprite
	{
		public function DefaultSkin()
		{
			super();
			var bgColor:uint=GlobalModel.defaultBgColor;
			var bgAlpha:Number=GlobalModel.defaultBgAlpha;
			this.graphics.beginFill(bgColor,bgAlpha);
			if(bgAlpha)
			{
				this.graphics.lineStyle(.1,0x000000);
			}
			this.graphics.drawRect(0,0,10,10);
			this.graphics.endFill();
			if(GlobalModel.defaultBgAlpha)
			{
				this.addEventListener(MouseEvent.ROLL_OVER,onOver);
			}
		}
		public function onOver(e:MouseEvent):void
		{
			trace(this.parent);
		}
	}
}