package com.aopui.admiral
{
	import client.mainui.view.panel.DefaultTipPanel;
	
	import com.aopui.core.IToolTipClient;
	import com.aopui.core.IToolTipPanel;
	import com.aopui.model.GlobalModel;
	import com.aopui.ui.Label;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;

	public class ToolTipAdmiral
	{
		public function ToolTipAdmiral()
		{
		}
		private static var toolTipLayer:Sprite;
		
		public static function show(tar:IToolTipClient,param:Object):void
		{
			if(toolTipLayer.numChildren>0)return;
			var toolTipType:String=tar.toolTipType;
			var toolTipClass:String=tar.toolTipClass;
			var toolTip:Object=tar.toolTip;
							
			var tip:Object;
			if(toolTipClass&&toolTipClass!=null)
			{
				var tipClass:Class=ResourceAdmiral.getClass(toolTipClass);
				var tipClassInstance:Object=new tipClass();
				if(tipClassInstance is IToolTipPanel)
				{
					tip=tipClassInstance;
					tip.data=tar.toolTip;
				}
				else
				{
					tip=new DefaultTipPanel();
					tip.data=tar.toolTip;
				}
			}
			else
			{
				if(toolTip!=null&&toolTip!="")
				{
					tip=new DefaultTipPanel();
					tip.data=tar.toolTip;
				}
			}
			
			if(!tip)
				return;
			toolTipLayer.addChild(tip as DisplayObject);
			switch(toolTipType)
			{
				case "vertical":
					var spr:Sprite=tar as Sprite;
					var bound:Rectangle=spr.getBounds(spr);
					var point:Point=spr.parent.localToGlobal(new Point(spr.x,spr.y));
//					var x:Number=point.x+bound.left+bound.width/2;
					var x:Number=point.x+spr.width/2;
//					var y:Number=point.y+bound.top;
					var y:Number=point.y;
					tip.x=x-tip.width/2+tar.offsetx;
					tip.y=y-tip.height-GlobalModel.tipoffsetY+tar.offsety;
					break;
				default:
					
					tip.x=param.x+10;
					tip.y=param.y+10;
					if(tip.width+tip.x>tip.stage.stageWidth)
						tip.x-=(tip.width+tip.x-tip.stage.stageWidth+3);			
					break;
			}
		}
		
		private static function isIToolTip(target:DisplayObject):Object
		{
			var parent:DisplayObject=target;
			if(parent is IToolTipClient)
			{
				return parent;
			}
			else
			{
				if(parent.parent)
					return isIToolTip(parent.parent as DisplayObject);
			}
			return null;
		}
		
		public static function init(tipLayer:Sprite,layers:Array):void
		{
			toolTipLayer=tipLayer;
			var tar:Object;
			var fover:Function=function(e:MouseEvent):void
			{
				tar=isIToolTip(e.target as DisplayObject);
				if(tar&&tar.toolTip!="")
				{
					show(tar as IToolTipClient,{x:e.stageX,y:e.stageY});
				}
			}
				
			var fout:Function=function(e:Event):void
			{
				tar=isIToolTip(e.target as DisplayObject);
				if(tar)
				{
					while(toolTipLayer.numChildren>0)
					{
						toolTipLayer.removeChildAt(0);
					}
				}
			}
				
			for each(var l:Sprite in layers)
			{
				l.addEventListener(MouseEvent.MOUSE_OVER,fover);
				l.addEventListener(MouseEvent.MOUSE_OUT,fout);
			}
			
		}
		
	}
}