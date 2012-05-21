package com.aopui.sdk.module
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	public class Plugin extends Sprite implements IAppModule
	{
		
//		[Embed(source="config.xml", mimeType="application/octet-stream")]
		private var ConfigClazz:Class;
//		protected var config:XML;
		public function Plugin()
		{
			super();
		}
		protected function set config(c:Class):void
		{
			ConfigClazz=c;
		}
		
		public function initialize():XML
		{
			var ba:ByteArray = new ConfigClazz();
//			var xml:XML=
			return new XML(ba);;
		}
	}
}