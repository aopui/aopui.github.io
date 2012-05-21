////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.resources
{

import flash.events.IEventDispatcher;
import flash.system.ApplicationDomain;
import flash.system.SecurityDomain;
    
public interface IResourceManager extends IEventDispatcher
{

    function get localeChain():Array /* of String */;

  
    function set localeChain(value:Array /* of String */):void;
    
 

    function addResourceBundle(resourceBundle:IResourceBundle):void;
    


   
    function update():void;

   
    function getLocales():Array /* of String */;




   
    function getResourceBundle(locale:String,
                               bundleName:String):IResourceBundle;

   
    function findResourceBundleWithResource(
                        bundleName:String,
                        resourceName:String):IResourceBundle;

    [Bindable("change")]
    

    [Bindable("change")]
    
    
    function getString(bundleName:String, resourceName:String,
                       parameters:Array = null,
                       locale:String = null):String;



   
    function installCompiledResourceBundles(
                                applicationDomain:ApplicationDomain,
                                locales:Array /* of String */,
                                bundleNames:Array /* of String */):void;


}

}
