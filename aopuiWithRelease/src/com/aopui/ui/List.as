/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui 
{
	import com.aopui.ui.list.ListBase;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class List  extends ListBase
	{
		public function List()
		{
			super();
			this.direction="horizon";
			this.SYNCSIZE=false;
			this.contentSpace.scrollRect=new Rectangle(0,0,1,1);
		}
		
		override public function layout():void
		{
			
			super.layout();
			rectX=marginLeft;
			rectY=this.marginTop;
			contentSpace.y=rectY;

			if(direction=="horizon")
			{
				rectW=this.width-marginLeft*2;
				rectH=this.height-marginTop*2;
				this.HLayout();
			}
			else
			{
				rectW=this.width-marginLeft*2;
				rectH=this.height-marginTop*2;
				this.VLayout();
			}
			
			this.contentSpace.scrollRect=new Rectangle(0,0,rectW,rectH);
			this.contentSpace.x=rectX;
			
		}
		
		override public function set data(d:Object):void
		{
			super.data=d;
		}
	}
}