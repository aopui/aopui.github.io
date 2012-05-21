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

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.TimerEvent;
import flash.system.SecurityDomain;
import flash.utils.getDefinitionByName;
import flash.utils.Timer;
import mx.utils.StringUtil;


public class ResourceManager
{
    private static var implClassDependency:ResourceManagerImpl;
    private static var instance:IResourceManager;
    public static function getInstance():IResourceManager
    {
        if (!instance)
        {
			instance = new ResourceManagerImpl();
			
        }
        
        return instance;
    }
    
}

}
