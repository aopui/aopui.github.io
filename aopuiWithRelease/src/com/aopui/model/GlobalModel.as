/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-9-3
* Michael
*/
package com.aopui.model
{
	import com.aopui.Marshal;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.sdk.app.Application;
	import com.aopui.sdk.module.ModuleAdmiral;
	import com.aopui.sdk.task.RookieTask;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[Bindable]
	public class GlobalModel
	{	
		public static var non_server:Boolean=false;
		public static var assetspre:String="";
		public static var firstAPI:String="user.get_all";
		public static var params:Object={};
		public static var cfgParamPrefix:String="cfg_";
		public static var serviceField:String="cfg_serviceUrl";
		public static var baseUrlField:String="cfg_baseUrl";
		public static var defaultBgAlpha:Number=0;
		public static var defaultBgColor:Number=0xff0000;
		public static var tipoffsetY:Number=0;
		public static var ationString:String;
		public static var requestType:String="POST";
		public static var fonts:Array=[];
		public static var initClass:XML=
							<root>
								<object type="client.mainui.MainUIMediator"/>
							</root>;
		/**
		 xmlns="http://www.spicefactory.org/parsley"
    						xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    						xsi:schemaLocation="http://www.spicefactory.org/parsley http://www.spicefactory.org/parsley/schema/2.3/parsley-core.xsd"
		 
		 * 
		 */
		public var state:String="";
		

		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var marshal:Marshal
		
//		[Inject]
//		public var rookieTask:RookieTask;
		
		public static var _dna:Object={};
		
		public var draggingItem:Object;
		public function GlobalModel()
		{
		}
		
		[Init]
		public function init():void
		{
//			hookEngineeringHotKey();
//			formatShopData(XML(_dna.xml.shopData));
			if(non_server)
			{
				return;
			}
			dispatcher(AllPowerfulMessage.create(AllPowerfulMessage.INIT_SCENE));
			
		}
		
		private function formatShopData(xml:XML):void
		{
			var c:Category=Category.preseXML(xml);
			_dna.shopData=c;
		}	
		
		protected function formatXML(xml:XML,propName:String=null):void
		{
			var c:Category=Category.preseXML(xml);
			_dna[propName]=c;
		}
		
		
		private function hookEngineeringHotKey():void
		{
			Application.app.scene.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.F12 && event.shiftKey && event.altKey && event.ctrlKey)
			{
				Application.app.startModule("engineering");
			}
		}
		
		public function get DNA():Object
		{
			return _dna;
		}
	}
}