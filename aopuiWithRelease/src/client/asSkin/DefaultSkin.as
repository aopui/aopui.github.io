package client.asSkin
{
	import flash.display.Sprite;
	
	public class DefaultSkin extends Sprite
	{
		public function DefaultSkin(color:uint=0xffffff,alpha:Number=.1)
		{
			this.graphics.beginFill(color,alpha);
			this.graphics.drawRect(0,0,10,10);
			this.graphics.endFill();
		}
	}
}