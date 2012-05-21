////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2005-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.resources
{

import flash.system.ApplicationDomain;


import mx.utils.StringUtil;


public class ResourceBundle implements IResourceBundle
{


    public static var locale:String;


	public static var backupApplicationDomain:ApplicationDomain;


    private static function getClassByName(name:String,
                                           domain:ApplicationDomain):Class
    {
        var c:Class;

        if (domain.hasDefinition(name))
            c = domain.getDefinition(name) as Class;

        return c;
    }

   
    public function ResourceBundle(locale:String = null,//使用
                                   bundleName:String = null)
    {
        super();
        
        _locale = locale;
        _bundleName = bundleName;

        _content = getContent();
    }  

   
	public var _bundleName:String;

   
    public function get bundleName():String
    {
        return _bundleName;
    }

  
    private var _content:Object = {};

   
    public function get content():Object
    {
        return _content;
    }

   
	public var _locale:String;

   
    public function get locale():String
    {
        return _locale;
    }

   
    protected function getContent():Object//用到
    {
        return {};
    }

    
    private function _getObject(key:String):Object
    {
        var value:Object = content[key];
        if (!value)
        {
            throw new Error("Key " + key +
                            " was not found in resource bundle " + bundleName);
        }
        return value;
    }
}

}
