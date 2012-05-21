package com.aopui.admiral
{

	import com.aopui.admiral.filterClass.Reflection;
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.net.FileFilter;

	public class FilterAdmiral
	{
		public function FilterAdmiral()
		{
		}
		
		public static function gray(mc:Object,disableMouse:Boolean=true):void
		{	
			mc.mouseChildren=!disableMouse;
			TweenMax.to(mc, 0, {colorMatrixFilter:{colorize:0xffffff}});
		}
		
		public static function removeFilter(mc:Object,disableMouse:Boolean=false):void
		{
//			TweenMax.to(mc, 0, {colorMatrixFilter:{}});
				if(!mc)
					return;
				mc.filters=[];
				mc.mouseChildren=!disableMouse;
		}
		
		public static function blur(target:DisplayObject,dsf:Object):void
		{
			var blurFilter:BlurFilter=getBlurFilter(dsf);
			ArrayAdmiral.delItemByType(target.filters,BlurFilter);
			target.filters=target.filters.concat(blurFilter);
		}
		
		
		public static function dropShadow(target:DisplayObject,dsf:Object):void
		{
			var dropShadow:DropShadowFilter=getDropShadowFilter(dsf);
			ArrayAdmiral.delItemByType(target.filters,DropShadowFilter);
			target.filters=target.filters.concat(dropShadow);			
		}
		
		public static function glow(target:DisplayObject,dsf:Object):void
		{
			var glowfilter:GlowFilter=getGlowFilter(dsf);
			
			ArrayAdmiral.delItemByType(target.filters,GlowFilter);
			target.filters=target.filters.concat(glowfilter);
		}
		
		public static function removeGlow(target:DisplayObject):void
		{
			target.filters=ArrayAdmiral.delItemByType(target.filters,GlowFilter);
		}
		
		public static function removeDropShadow(target:DisplayObject):void
		{
			target.filters=ArrayAdmiral.delItemByType(target.filters,DropShadowFilter);			
		}
		
		public static function getBlurFilter(dsf:Object):BlurFilter
		{
			var bf:BlurFilter=new BlurFilter();
			
			if(!dsf.hasOwnProperty("blurY"))
			{
				dsf.blurY=4;
			}
			
			if(!dsf.hasOwnProperty("blurX"))
			{
				dsf.blurY=4;
			}
			
			if(!dsf.hasOwnProperty("quality"))
			{
				dsf.quality = BitmapFilterQuality.HIGH;
			}
			
			bf.blurX=dsf.blurY;
			bf.blurY=dsf.blurX;
			bf.quality=dsf.quality;			
			return bf;
		}
		
		
		public static function getDropShadowFilter(dsf:Object):DropShadowFilter
		{
			var ds:DropShadowFilter =new  DropShadowFilter();
			
			if(!dsf.hasOwnProperty("distance"))
			{
				dsf.distance=2;
			}
			
			if(!dsf.hasOwnProperty("angle"))
			{
				dsf.angle=90;
			}
			
			if(!dsf.hasOwnProperty("color"))
			{
				dsf.color=0x000000;
			}
			
			if(!dsf.hasOwnProperty("alpha"))
			{
				dsf.alpha=1;
			}
			
			if(!dsf.hasOwnProperty("blurX"))
			{
				dsf.blurX=4;
			}
			
			if(!dsf.hasOwnProperty("blurY"))
			{
				dsf.blurY=4;
			}
			if(!dsf.hasOwnProperty("strength"))
			{
				dsf.strength=1;
			}
			if(!dsf.hasOwnProperty("quality"))
			{
				dsf.quality=1;
			}
			
			if(!dsf.hasOwnProperty("inner"))
			{
				dsf.inner=false;
			}
			
			if(!dsf.hasOwnProperty("knockout"))
			{
				dsf.knockout=false;
			}
			
			if(!dsf.hasOwnProperty("hideObject"))
			{
				dsf.hideObject=false;
			}
			//			distance,angle,color,alpha,blurX,blurY,strength,quality,inner,knockout,hideObject
			ds.distance=Number(dsf.distance);
			ds.angle=Number(dsf.angle);
			ds.color = uint(dsf.color);
			ds.alpha = Number(dsf.alpha);
			ds.blurX = Number(dsf.blurX);
			ds.blurY = Number(dsf.blurY);
			ds.strength = Number(dsf.strength);
			ds.quality = Number(dsf.quality);
			ds.inner=dsf.inner;
			ds.knockout=dsf.knockout;
			ds.hideObject=dsf.hideObject;
			return ds;
		}
		
		/**							
		 *@param gf
		 * 默认值
		 *{color:0xFFFFFF,blur:2,strength,alpha:1}
		 */
		public static function getGlowFilter(gf:Object):GlowFilter
		{
			var txtGlow:GlowFilter = new GlowFilter(); 
			if(!gf.hasOwnProperty("color"))
			{
				gf.color=0xFFFFFF;
			}
			if(!gf.hasOwnProperty("blur"))
			{
				gf.blur=2;
			}			
			if(!gf.hasOwnProperty("strength"))
			{
				gf.strength=10;
			}
			if(!gf.hasOwnProperty("alpha"))
			{
				gf.alpha=1;
			}
			if(!gf.hasOwnProperty("inner"))
			{
				gf.inner=false;
			}
			txtGlow.inner=gf.inner;
			txtGlow.color = uint(gf.color);
			txtGlow.alpha = Number(gf.alpha);
			txtGlow.blurX = Number(gf.blur);
			txtGlow.blurY = Number(gf.blur);
			txtGlow.strength = Number(gf.strength);
			txtGlow.quality = BitmapFilterQuality.HIGH;			
			return txtGlow;
		}
		
		public static function getReflection(target:DisplayObject, set_numStartFade:Number=.4, set_numMidLoc:Number=.2, set_numEndFade:Number=0, set_numSkewX:Number=0, set_numScale:Number=1):DisplayObject
		{
			var r:Reflection=new Reflection();
			return r.getReflection(target,set_numStartFade,set_numMidLoc,set_numEndFade,set_numSkewX,set_numScale);			
		}
		
	}
}