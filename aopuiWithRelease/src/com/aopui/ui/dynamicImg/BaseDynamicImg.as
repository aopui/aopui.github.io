////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 21, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.ui.dynamicImg
{
	import com.aopui.event.DynamicImgEvent;
	import com.aopui.event.EventBase;
	import com.aopui.ui.Label;
	import com.aopui.ui.list.RenderBase;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class BaseDynamicImg extends RenderBase
	{
		public static var LayerType:String="layerType";
		public static var FrameType:String="frameType";
		public var animationType:String=LayerType;
		public  var frameSeed:int=3;
		public var _imgWidth:Number;
		public var _imgHeight:Number;
		
		[Inspectable(enumeration="left","center","right","none")]
		public var cute:String="none";
		protected var _preIcon:Label=new Label();
		protected var _source:Object
		public var roundCorner:Boolean=false;
		public var roundCornerSize:Number=0;
		protected var _loader:Loader=new Loader();
		public function BaseDynamicImg()
		{
			super();
			needBGEffect=false;
		}
		override public function set imgHeight(value:Number):void
		{
			_imgHeight=value;
		}
		override public function get  imgHeight():Number
		{
			return _imgHeight
		}
		override public function get imgWidth():Number
		{
			return _imgWidth;
		}
		override public function set imgWidth(value:Number):void
		{
			_imgWidth=value
		}
		
		
		override public function setParam(param:Object):void
		{
			if(param&&param.animationType)
				animationType=param.animationType;
			if(param&&param.frameRate)
				frameSeed=param.frameRate;
		}
		
		protected function getLeft(bd:BitmapData,bgColor:uint=0x00000000):Number
		{
			for(var i:int=1;i<=bd.width;i++)
			{
				for(var j:int=1;j<=bd.height;j++)
				{
					var color:uint=bd.getPixel(i,j);
					if(color!=bgColor)
						return i;
				}
			}
			return 0;
		}
		protected function getTop(bd:BitmapData,bgColor:uint=0x00000000):Number
		{
			for(var i:int=1;i<=bd.width;i++)
			{
				for(var j:int=1;j<bd.height;j++)
				{
					var color:uint=bd.getPixel(j,i);
					if(color!=bgColor)
						return i;
				}
			}
			return 0;
		}
		
		private var _horizonOpenRectX:Number=0;
		public function set horizonOpen(rectx:Number):void
		{
			_horizonOpenRectX=rectx;
			this.scrollRect=new Rectangle(rectx,0,this.imgWidth-rectx*2,this.imgHeight);
		}
		
		public function get horizonOpen():Number
		{
			return this._horizonOpenRectX;
		}
		
		private var mc:MovieClip;
		private var reallyHeight:Number;
		private var reallyWidth:Number;
		public var mcx:Number
		protected function onComp(e:Event):void
		{
			
			if(_preIcon)this.removeChild(_preIcon);
			mc=_loader.content as MovieClip;
			
		
			if(!mc)
			{
				mc=new MovieClip;
			}
			else
			{
				while(mc.numChildren)
				{
					mc.removeChildAt(0);
				}
			}
			if(this.cute=="center")
			{
				this.scrollRect=new Rectangle(0,0,this.imgWidth,this.imgHeight);
				_horizonOpenRectX=0;
			}
			this.addChild(mc);
			
			
			var b:Bitmap=new Bitmap();
			var bd:BitmapData;
			if(!(_loader.content is Bitmap))
			{
				bd=new BitmapData(_loader.contentLoaderInfo.width,_loader.contentLoaderInfo.height,true,0x00000000);
				bd.draw(mc);
				b.bitmapData=bd;
			}
			if(_loader.content is Bitmap)
			{
				if(_loader.content is Bitmap)
//					mc=new MovieClip();
//				mc.width=imgWidth;
//				mc.height=imgHeight;
					mc.addChild(_loader.content);
					
			}
			
			
			
			//			this.addChild(b);
			mc.mouseEnabled=false;
			if(this.animationType==BaseDynamicImg.FrameType)
			{
				if(!(_loader.content is Bitmap))
				{
					for(var i:int=0;i<mc.numChildren;i++)
					{
						var tmpmc:Object=mc.getChildAt(i);
						var left:Number=getLeft(bd);
						var top:Number=getTop(bd);
						tmpmc.x-=left;
						tmpmc.y-=top;
					}				
				}
			}
			var scaleValue:Number=getScaleValue(mc);
			
			addMask();
			
			if(_loader.content is Bitmap)
			{
				Object(_loader.content).smoothing=true;
				if(cute=="center"){
					var sValue:Number=1;
					//如果是左右居中剪切 缩放值 是 imgHeight与_loader.content.height比较出来的值为准
					if(imgHeight>_loader.content.height)
					{
						sValue= imgHeight/_loader.content.height;
					}
//					_loader.content.scaleX=_loader.content.scaleY=sValue;
					mc.x=this.imgWidth/2-mc.width/2;
					mcx=mc.x;
				}
				else
				{
					mc.width=imgWidth;
					mc.height=imgHeight;
				}
				
			}
			else
			{			
				mc.scaleX=scaleValue;
				mc.scaleY=scaleValue;
				
				if(this.animationType==BaseDynamicImg.LayerType)
				{
					this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
				}
			}
			this.dispatchEvent(EventBase.createEvent(DynamicImgEvent.LOADED));
		}
		
		private function getScaleValue(mc:DisplayObject):Number
		{
			var scaleValue:Number;
			var scaleValueW:Number;
			var scaleValueH:Number;
			if(this.imgWidth)
			{
//				if(mc.width>imgWidth)
					scaleValue=scaleValueW=this.scaleByWidth(imgWidth,mc);
				
			}
			if(this.imgHeight)
			{
//				if(mc.height>imgHeight)
					scaleValue=scaleValueH=this.scaleByHeight(imgHeight,mc);
//				else
					
			}
			
			if(scaleValueW&&scaleValueH)
			{				
				scaleValueW>scaleValueH?scaleValue=scaleValueH:scaleValue=scaleValueW;
			}
			if(!scaleValue)scaleValue=1;
			return scaleValue;
		}
		
		private function catchImg(m:MovieClip):void
		{
			mc=m;
			if(!mc)
				mc=new MovieClip;			
			var b:Bitmap=new Bitmap();
			var bd:BitmapData;
			var mmc:Sprite=new Sprite();
				mmc.addChild(privatemc);
				privatemc.height=imgHeight;
				privatemc.width=imgWidth;
			var bound:Rectangle=getBounds(mmc);
				
			var matrix:Matrix=new Matrix(1,0,0,1,bound.left,bound.top);
				bd=new BitmapData(bound.width,bound.height,true,0x00000000);
				bd.draw(mmc,matrix);
				b.bitmapData=bd;
			addChild(b);
//			addMask();
			this.dispatchEvent(EventBase.createEvent(DynamicImgEvent.LOADED));
				
		}
		
		private function addMask():void
		{
			if(roundCorner)
			{
				var s:Sprite=new Sprite();
					s.graphics.beginFill(0xffffff);
					var cornerSize:Number=this.roundCornerSize;
					if(!cornerSize)
						cornerSize=imgWidth/7
					s.graphics.drawRoundRect(0,0,imgWidth,imgHeight,cornerSize,cornerSize);
					s.graphics.endFill();
					this.addChild(s);
					this.mask=s;
			}
		}
		
		
		private var frameIndex:int=1;
		private var frameFlag:int=0;		
		private function onEnterFrame(e:Event):void
		{
			frameFlag++;
			var typpmc:DisplayObject
			if(frameFlag!=frameSeed)return;
			frameFlag=0;
			try{
				for(var i:int=0;i<mc.numChildren;i++)
				{
					typpmc=mc.getChildAt(i);
					if(typpmc)typpmc.visible=false;
				}
				
				typpmc=mc.getChildAt(frameIndex-1)
			}catch(o:Object){}
			if(typpmc)typpmc.visible=true;
			frameIndex++;
			if(frameIndex>mc.numChildren)frameIndex=1;
		}
		
		
		private var privatemc:DisplayObject;
		public function set source(value:*):void
		{
			
				
			if(_source==value)return;
			if(!value)
			{
				removeAllChild();
				return;
			}
			privatemc=null;
			_source=value;
			this.removeAllChild();
			if(this.mask)this.mask=null;
			if(this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			if(_preIcon)
			{
				_preIcon.text="Loading"
				this.addChild(_preIcon);
			}
			
			if(value is String)
			{
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComp);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
				if(this.autoDestroyImg)
				{
					this._loader.addEventListener(Event.ENTER_FRAME,onLoaderEnterFrame);
				}
				else
				{
					_loader.load(new URLRequest(value+""));
				}
			}
			else if(value is Class)
			{
				privatemc=new value();
				
			}
			else if(value is DisplayObject)
			{
				privatemc=value;
			}
			if(privatemc)
			{
				this.addChild(privatemc);
				if(privatemc)
					stop(privatemc);
				
				var mmc:Sprite=new Sprite();
				var scaleValue:Number=getScaleValue(privatemc);
				privatemc.scaleX=privatemc.scaleY=scaleValue;
				var bound:Rectangle=getBounds(privatemc);
				var left:Number=-bound.left;
				var top:Number=-bound.top;
				var xoffset:Number=this.imgWidth-privatemc.width;//*scaleValue;
				var yoffset:Number=this.imgHeight-privatemc.height;//*scaleValue;
				privatemc.x=left*scaleValue+xoffset/2;
				privatemc.y=top*scaleValue+yoffset/2;
				
//				catchImg(privatemc as MovieClip);
				_preIcon.visible=false;
			}			
			addMask();
		}
		
		private var _showed:Boolean=false;
		private var incTmp:int=1;
		private function onLoaderEnterFrame(e:Event):void
		{
			incTmp++
			if(incTmp!=3)
				return;
			incTmp=1;
			if(!this.stage)
				return;
			var thisP:Point= this.parent.localToGlobal(new Point(this.x,this.y));
			if(thisP.x<this.stage.stageWidth&&thisP.x+this.width>0)
			{
//				TweenMax.delayedCall(.5,function():void
//							{
				if(!_showed)
				{
							_loader.load(new URLRequest(_source+""))
								_showed=true;
				}
//							}
//					)
			}
			else
			{	
//				_showed=false;
////				if(mc&&mc.parent)
////					mc.parent.removeChild(mc);
//				this._loader.unload();
//				this._loader.unloadAndStop();
				
			}
		}
		
		private function stop(mc:Object):void
		{
			if(mc is MovieClip)
				mc.stop();
			if(mc is Sprite && mc.numChildren>0)
			{
				for(var i:int=0;i<mc.numChildren;i++)
				{
					var m:Object=mc.getChildAt(i);
					stop(m);					
				}
			}			
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			
		}
		
		public function copySource():*
		{
			if(this.mc)
			{
				var ba:ByteArray=new ByteArray();
					ba.writeObject(mc);
					ba.position = 0;
				return ba.readObject();
			}
			return null;
		}
		
		override public function destroy():void
		{
			
			if(this.hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
			if(_loader&&_loader.hasEventListener(Event.ENTER_FRAME))
				_loader.removeEventListener(Event.ENTER_FRAME,onLoaderEnterFrame);
			if(this._loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComp);
			if(this._loader.hasEventListener(IOErrorEvent.IO_ERROR))
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			
			if(mc&&mc.parent)
				mc.parent.removeChild(mc);			
			if(mc)
				mc=null;
			this._loader.unload();
			_loader=null;
		}
		
		public function get source():Object
		{
			return _source;
		}
		
		override public function getUI(clsName:String):Class
		{
			return _loader.contentLoaderInfo.applicationDomain.getDefinition(clsName) as Class;
		}
	}
}