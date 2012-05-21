package com.aopui.admiral
{
	import com.aopui.core.ContentLayer;
	import com.aopui.ui.BasicUI;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class LayoutAdmiral
	{
		public function LayoutAdmiral()
		{
			
		}
		
		public static function layoutSize(ui:Object):void
		{
			var parentW:Number;
			var parentH:Number;
			if(!scene)return;
			if(ui.parentui)
			{				
				parentW=ui.parentui.width;
				parentH=ui.parentui.height;

				if(ui.parentui.hasOwnProperty("pageEffect")&&ui.parentui.pageEffect)
				{
					parentW=ui.parentui.width-ui.parentui.pageEffect.getVerticalScrollBarW();
					parentH=ui.parentui.height-ui.parentui.pageEffect.getHorizonScrollBarH();
				}
			}
			else
			{
				parentW=scene.stage.stageWidth;
				parentH=scene.stage.stageHeight;
			}
			
			if(ui.top>-1&&ui.bottom>-1)
			{
				ui.y=ui.top;
				ui.height=parentH-ui.bottom-ui.top;
			}
			
			if(ui.left>-1&&ui.right>-1)
			{
				ui.x=ui.left;
				ui.width=parentW-ui.right-ui.left;
			}
		}
		
		
		public static var scene:Sprite;
		public static function layoutPosition(ui:Object):void
		{
			var parentW:Number;
			var parentH:Number;
			if(!scene)return;
			if(ui.parentui)
			{				
				parentW=ui.parentui.width;
				parentH=ui.parentui.height;
				
				if(ui.parentui.hasOwnProperty("pageEffect")&&ui.parentui.pageEffect)
				{
					parentW=ui.parentui.width-ui.parentui.pageEffect.getVerticalScrollBarW();
					parentH=ui.parentui.height-ui.parentui.pageEffect.getHorizonScrollBarH();
				}
			}
			else
			{
				parentW=scene.stage.stageWidth;
				parentH=scene.stage.stageHeight;
			}
			
			
			if(ui.left>-1&&ui.right>-1)
			{
			}
			else
			{
				if(ui.left>-1)
					ui.x=ui.left;
				if(ui.right>-1)
					ui.x=parentW-ui.right-ui.width;
			}			
			
			if(ui.top>-1&&ui.bottom>-1)
			{
			}
			else
			{
				if(ui.top>-1)
					ui.y=ui.top;
				if(ui.bottom>-1)
					ui.y=parentH-ui.bottom-ui.height;
			}
			
			if(ui.globalAlign)
			{
				var alignData:Array=ui.globalAlign.split(",")
				switch(alignData[0])
				{
					case "S":
						ui.x=parentW/2-ui.width/2;
						ui.y=parentH-ui.height;							
						break;
					case "N":
						ui.y=0;
						ui.x=parentW/2-ui.width/2;
						break;
					case "E":
						ui.x=parentW-ui.width;
						ui.y=parentH/2-ui.height/2;
						break;
					case "W":
						ui.x=0;
						ui.y=parentH/2-ui.height/2;
						break;
					case "EN":
					case "NE":
						ui.y=0;
						ui.x=parentW-ui.width;
						break;
					case "WN":
					case "NW":
						ui.y=0;
						ui.x=0;
						break;
					case "ES":
					case "SE":
						ui.x=parentW-ui.width;
						ui.y=parentH-ui.height;
						break;
					case "WS":
					case "SW":
						ui.x=0;
						ui.y=parentH-ui.height;
						break;
					case "C":
						ui.x=parentW/2-ui.width/2;
						ui.y=parentH/2-ui.height/2;
						break;
					case "VC":
					case "CV":
						ui.y=parentH/2-ui.height/2;
						break;
					case "HC":
					case "CH":
						ui.x=parentW/2-ui.width/2;
						break;
					default:
						break;
				}
//				if(ui.x<0)
//					ui.x=0;
//				if(ui.y<0)
//					ui.y=0;
				if(alignData.length>1)
				{
					for(var i:int=1;i<alignData.length;i++)
					{
						tuning(ui,alignData[i]);
					}
				}					
			}
		}
		
		public static function changeSence():void
		{
			switch (scene.stage.displayState) {
				case "normal" :						
					scene.stage.displayState="fullScreen";
					break;
				case "fullScreen":
					scene.stage.displayState="normal";
					break;
				default :
					scene.stage.displayState="normal";
					break;
			}
		}
		
		public static function showInCenter(ui:DisplayObject,offsetX:Number=0,offsetY:Number=0):void
		{
			ui.x=scene.stage.stageWidth/2-ui.width/2+offsetX;
			ui.y=scene.stage.stageHeight/2-ui.height/2+offsetY;
		}
		
		public static function getCenterPoint(ui:Object,offsetX:Number=0,offsetY:Number=0):Point
		{
			var p:Point=new Point();
			p.x=scene.stage.stageWidth/2-ui.width/2+offsetX;
			p.y=scene.stage.stageHeight/2-ui.height/2+offsetY;
			return p;
		}
		
		private static function tuning(ui:Object,param:String):void
		{
			param=param.toLocaleLowerCase();
			var align:String=param.substr(0,1);
			var value:String=param.substr(1);			
			ui[align]+=Number(value);
		}
	}
}