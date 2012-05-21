package com.aopui.admiral
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.Font;

	public class FontAdmiral
	{
		private static var _fontFormats:Object={}
		public function FontAdmiral()
		{
		}
		public static function regFont(myFontClass:Object):void
		{
			if(!myFontClass||!myFontClass.font)
			{
				trace("注册字体失败");
				return;
			}
			myFontClass=myFontClass.font;
			Font.registerFont(myFontClass as Class);
		}
		
		/**							
		 *@param tf
		 *  align(left,center,justify,right);	
		 * {字体,字号,颜色,粗体,斜体,下划线,URL,target,对齐方式,左边距,右边距,缩进,行距}
		 * {font,size,color,bold,italic,underline,url,target,align,leftMargin,rightMargin,indent,leading}
		 * target是显示超链接的目标窗口
		 */
		public static function addFont(fName:String,tf:Object):void
		{
			if(tf.gf)
				tf.gf=FilterAdmiral.getGlowFilter(tf.gf);
			if(tf.dsf)
				tf.dsf=FilterAdmiral.getDropShadowFilter(tf.dsf);
			_fontFormats[fName]=tf;
		}
		
		public static function getFont(fName:String):Object
		{
			return _fontFormats[fName];
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
			txtGlow.color = uint(gf.color);
			txtGlow.alpha = Number(gf.alpha);
			txtGlow.blurX = Number(gf.blur);
			txtGlow.blurY = Number(gf.blur);
			txtGlow.strength = Number(gf.strength);
			txtGlow.quality = BitmapFilterQuality.LOW;			
			return txtGlow;
		}
		
	}
}