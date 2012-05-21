package com.aopui.admiral
{
	import com.aopui.effect.PageFlip;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	public class StateAdmiral
	{
		public function StateAdmiral()
		{
		}
		public static var stateEffectLayer:Sprite;
		
		public static var isHorizontal:Boolean=true;
		
		private static var  page0:BitmapData;
		private static var page1:BitmapData;
		private static var renderShap:Shape;
		public static var first:Boolean=true;
		public static function excute():void
		{
			if(first)
			{
				first=false;
				return;
			}
			var s:Stage=stateEffectLayer.stage;
			var bitMap:Bitmap=new Bitmap();
			var bitMapData:BitmapData=new BitmapData(s.stageWidth,s.stageHeight,true);
			bitMapData.draw(s);
			if(!renderShap)
				renderShap=new Shape();
			stateEffectLayer.addChild(renderShap);
			
			page0=bitMapData;
			page1=new BitmapData(s.stageWidth,s.stageHeight,true,0xff00ff00);
			page1=bitMapData;
			var stateAdmiral:StateAdmiral=new StateAdmiral();	
			if(isHorizontal){
				TweenMax.fromTo(stateAdmiral,2,{page:stateEffectLayer.stage.stageWidth-60},{page:-stateEffectLayer.stage.stageWidth-60,ease:Circ.easeIn,onComplete:onComp});
			}else{
				TweenMax.fromTo(stateAdmiral,2,{page:stateEffectLayer.stage.stageHeight-60},{page:-stateEffectLayer.stage.stageHeight-60,ease:Circ.easeIn,onComplete:onComp});
			}
			
			
//			var o:Object=PageFlip.computeFlip(	new Point(1,50);	// flipped point
//				new Point(1,1),		// of bottom-right corner
//				page0.width,		// size of the sheet
//				page1.height,
//				true,				// in horizontal mode
//				1);					// sensibility to one 
//			
//			
//			PageFlip.drawBitmapSheet(o,					// computeflip returned object
//				renderShap,					// target
//				page0,		// bitmap page 0
//				page1);		// bitmap page 1
		}
		
		private static function onComp():void
		{
			renderShap.graphics.clear();
		}
		
		private  var _point:Point=new Point(1,1);
		
		public function get page():Number
		{
			return _point.x;
		}
		public function set page(value:Number):void
		{
			renderShap.graphics.clear();
			
			
			if(isHorizontal)
				_point=new Point(value,stateEffectLayer.stage.stageHeight-60);
			else
				_point=new Point(stateEffectLayer.stage.stageWidth-60,value);
			
			var o:Object=PageFlip.computeFlip(_point,	// flipped point
				new Point(1,1),		// of bottom-right corner
				page0.width,		// size of the sheet
				page1.height,
				isHorizontal,				// in horizontal mode
				1);					// sensibility to one 
			
			
			PageFlip.drawBitmapSheet(o,					// computeflip returned object
				renderShap,					// target
				page0,		// bitmap page 0
				page1);		// bitmap page 1
		}
	}
}