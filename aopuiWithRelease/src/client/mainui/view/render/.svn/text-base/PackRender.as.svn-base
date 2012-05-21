////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 3, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package client.mainui.view.render
{
	import com.aopui.event.DynamicImgEvent;
	import com.aopui.ui.list.RenderBase;
	
	import flash.events.Event;

	public class PackRender extends RenderBase
	{
		public function PackRender()
		{
			
			super();
			var x:XML=
				<layout skinClass="com.aopui.assets.RenderSkin">
						<DynamicImg id="img" 
								imgWidth="70" imgHeight="60" 
								mouseChildren="false" 
								eventListener={DynamicImgEvent.LOADED+",onImgLoaded"}/>
						<Label id="num" x="65" y="50"/>
				</layout>
			this.xml=x;	
		}
		public function get source():Object
		{
			return $.img.source;
		}
		public function set source(o:Object):void
		{
			$.img.source=o;
		}
		
		override public function set data(d:Object):void
		{
			super.data=d;
			$.num.text=d.num;
			try{
				$.img.source="resources/"+d.itemType+"/"+data.nameid+(d.itemType=="fish"?"5":"")+".swf";
			}catch(o:Object){}
			layout();
		}
		public function copySource():*
		{
			return $.img.copySource();
		}
		override public function layout():void
		{
			$.img.x=this.width/2-$.img.width/2;
			$.img.y=this.height/2-$.img.height/2;
		}
		
		override public function setParam(param:Object):void
		{
			$.img.setParam(param);
		}
		public function onImgLoaded(e:Event):void
		{
			$.img.x=this.width/2-$.img.width/2;
			$.img.y=this.height/2-$.img.height/2;
		}
	}
}