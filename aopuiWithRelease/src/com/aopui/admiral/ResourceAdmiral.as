////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 25, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.admiral
{
	import com.aopui.sdk.app.Application;
	
	import flash.display.Loader;
	import flash.system.ApplicationDomain;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class ResourceAdmiral
	{
		private static var _resource:IResourceManager
		private static var _applicationDomain:ApplicationDomain;
		public function ResourceAdmiral()
		{
		}

		public static function get applicationDomain():ApplicationDomain
		{
			return _applicationDomain;
		}

		public static function set applicationDomain(value:ApplicationDomain):void
		{
			_applicationDomain = value;
		}

		private static var _basePackageName:String;
		public static function init(appDomain:ApplicationDomain,basePackageName:String):void
		{
			_applicationDomain=appDomain;
			_resource=ResourceManager.getInstance();
			_basePackageName=basePackageName;
			
		}
		public static function getString(resourceName:String,
										 parameters:Array = null,
										 bundleName:String="strings",
										 locale:String = null):String
		{
			return _resource.getString(bundleName,resourceName,parameters,locale);
		}
		public static function getUI(clsName:String):Object
		{
			var c:ApplicationDomain=_applicationDomain;
//				c=ApplicationDomain.currentDomain;
			var cls:Object;
			cls=getResource(_basePackageName+clsName);
			if(!cls)
				return getResource(clsName)
			return cls;
			
			if(!c.hasDefinition(_basePackageName+clsName))
				return c.getDefinition(clsName);
			cls=c.getDefinition(_basePackageName+clsName);
			return cls;
		}
		public static function getClass(clsName:String):Class
		{
			var cls:Class=getUI(clsName) as Class;			
			return cls;
		}
		
		public static function getResource(className:String):Class
		{
			var o:*;//
			try{
				o=_applicationDomain.getDefinition(className);
			}catch(xx:Object)
			{}
			if(o)
				return o as Class;
			try{
				o=ApplicationDomain.currentDomain.getDefinition(className);			
			}catch(o:Object){}
			if(o)
				return o as Class;
			for each(var loader:Loader in Application.loaders)
			{
				try{
					o=loader.contentLoaderInfo.applicationDomain.getDefinition(className);
				}catch(e:Object){}
				if(o)
					return o as Class;
			}
			return null;
		
		}
		
	}
}