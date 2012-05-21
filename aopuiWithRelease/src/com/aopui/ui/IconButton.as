package com.aopui.ui
{
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.ui.list.RenderBase;

	public class IconButton extends  RenderBase
	{
		public function IconButton()
		{
			super();
			xml=<layout WH="90,115">
						<Button id="icon" globalAlign="N" WH="80,90"/>
						<Button id="label" globalAlign="S" WH="80,30" autoSize="true" mouseEnabled="false" mouseChildren="false" />
					</layout>
		}
		
		public function set iconGlobalAlign(align:String):void
		{
			$.icon.globalAlign=align;
			this.invalidate();
		}
		
		public function set iconWH(value:String):void
		{
			var ar:Array=value.split(",");
			var w:Number=Number(ar[0]);
			var h:Number=Number(ar[1]) ;
			$.icon.width=w;
			$.icon.height=h;
		}
		
		public function labelAutoSize(b:Boolean):void
		{
			$.label.autoSize=b;
		}
		
		public function set labelWH(value:String):void
		{
			var ar:Array=value.split(",");
			var w:Number=Number(ar[0]);
			var h:Number=Number(ar[1]) ;
			$.label.width=w;
			$.label.height=h;
		}
		
		public function set labelGlobalAlign(align:String):void
		{
			$.label.globalAlign=align;
			this.invalidate();
		}
		
		public function set iconSkin(skinName:String):void
		{
			$.icon.skinClass=ResourceAdmiral.getClass(skinName);
			this.invalidate();
		}
		
		override public function set font(font:Object):void
		{
			$.label.font=font;
			this.invalidate();
		}
		
		public function set text(text:String):void
		{
			$.label.text=text;
			this.invalidate();
		}
		
		public function set labelSkin(skinName:String):void
		{
			$.label.skinClass=ResourceAdmiral.getClass(skinName);
			this.invalidate();
		}
		
		override public function layout():void
		{
			super.layout();
		}
	}
}