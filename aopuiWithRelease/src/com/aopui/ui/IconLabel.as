package com.aopui.ui
{
	public class IconLabel extends Panel
	{
		public function IconLabel()
		{
			super();
			xml=<layout>
					<Label id="label"/>
					<Panel id="icon"/>
				</layout>
		}
		
		override public function set font(ft:Object):void
		{
			super.font=ft;
			$.label.font=ft;
		}
		
		
		override public function set iconLeft(value:Number):void
		{
			super.iconLeft=value;
		}
		
		override public function set iconTop(value:Number):void
		{
			super.iconTop=value;
		}
		
		override public function set marginTop(value:Number):void
		{
			super.marginTop=value;
			$.label.marginTop=value;
		}
		
		override public function set marginBottom(value:Number):void
		{
			super.marginBottom=value;
			$.label.marginBottom=value;
		}
		
		override public function set marginRight(value:Number):void
		{
			super.marginRight=value;
			$.label.marginRight=value;
		}
		
		override public function set marginLeft(value:Number):void
		{
			super.marginLeft=value;
			$.label.marginLeft=value;
		}
		
		public function set text(value:String):void
		{
			$.label.text=value;
		}
		
		public function get text():String
		{
			return $.label.text;
		}
		
		
		override public function set skinClass(cls:Object):void
		{
			$.label.skinClass=cls;
		}
		
		private var _icon:*;
		override public function set icon(value:*):void
		{			
//			if(value is Class)value=new value;
			$.icon.skinClass=value;
			this.invalidate();
		}
		
//		override protected function layoutSize():void
//		{
//			super.layoutSize();
//		}
//		
//		override protected function layoutPosition():void
//		{
//			super.layoutPosition();
//			
//				
//		}
		
		override public function layout():void
		{
//			super.layoutSelfSize();
			super.layoutSize();
			super.layoutPosition();
			if(this.iconLeft<0)
			{
				$.label.x=-this.iconLeft;
				
			}
			else
			{
				$.icon.x=this.iconLeft;
				
			}
			
			if(this.iconTop<0)
			{
				$.label.y=-this.iconTop;
			}
			else
			{
				$.icon.y=this.iconTop;
			}
			if(this.iconWidth)
				this.$.icon.width=this.iconWidth;
			if(this.iconHeight)
				this.$.icon.height=this.iconHeight;
			layoutSelfSize();
			
		}
		
	}
}