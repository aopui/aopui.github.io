package client.mainui.view.render
{
	import com.aopui.ui.dynamicImg.BaseDynamicImg;
	import com.aopui.ui.list.RenderBase;
	import com.rekoo.util.display.ClippedImage;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	public class BuddyListRender extends RenderBase
	{
		
		public function BuddyListRender()
		{
			var x:XML=<layout skinClass="FriendRenderBg" mouseChildren="false">
							<DynamicImg id="img" 
										imgHeight="50"
										imgWidth="50" 
										x="5" y="18" 
										roundCorner="true"
										animationType={BaseDynamicImg.FrameType}/>
					  </layout>
				this.xml=x;
				$.img.source=getUI("DefaultPicForInvite");
		}
		
		override public function layout():void
		{
				super.layout();
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if (!value) return;
			if(data.headUrl=="")
				$.img.source=getUI("DefaultPic");
			$.img.source = data.headUrl;
			
		}
	}
}