package client.mainui
{	
	import client.model.State;
	import client.panel.ButtonExample;
	import client.panel.ScrollBarExample;
	import client.panel.ToggleListExample;
	
	import com.aopui.admiral.LayoutAdmiral;
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.admiral.StateAdmiral;
	import com.aopui.command.AllPowerfulCommand;
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.ui.Button;
	import com.aopui.ui.DynamicImg;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import mx.binding.utils.BindingUtils;

	public class MainUIMediator extends BasicMainUIMediator
	{
	
		
		public function MainUIMediator()
		{			
			super();
		}

		private var pan1:ButtonExample;
		private var toggleListExample:ToggleListExample
		private var scrollBarExample:ScrollBarExample;
		override public function init():void
		{
			super.init();
			
			
//			pan1=new ButtonExample();	
//			marshal.uiLayer.addChild(pan1);
//			toggleListExample=new ToggleListExample();
//			marshal.uiLayer.addChild(toggleListExample);
			scrollBarExample=new ScrollBarExample();
			marshal.uiLayer.addChild(scrollBarExample);
//			model.state="toggleList"
		}
		
	
	}
}