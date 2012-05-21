////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 8, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.ui.alert
{
	import com.aopui.admiral.PopupAdmiral;
	import com.aopui.ui.ContainBase;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Alert extends ContainBase
	{
		public function Alert()
		{
			super();
			this.navigation=false;
			var x:XML=<Layout skinClass="DefaultAlertSkin">
						<Area id="area" x="20" y="20" width="260" height="160"/>
						<Button id="closeBtn" 
							skinClass="AlertCloseBtnSkin"
							x="217"
							y="10.45"
							eventListener={MouseEvent.CLICK+",close"}/>
						<HBox id="buttons"/>
					  </Layout>
			this.xml=x;
		}
		public function close(e:Event):void
		{
			PopupAdmiral.close();
		}
		
		/**
		 *{txt:"",noCloseBtn:false,buttons:{label:"",callBack:}}
		 **/
		public function set data(d:Object):void
		{
			$.area.text=d["txt"];
			if(d["buttons"])
			{
				
			}
			if(d["model"])
			{
				
			}
			if(d["noCloseBtn"])
			{
				$.visible=false;
			}
		}
	}
}