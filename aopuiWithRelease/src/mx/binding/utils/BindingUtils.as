////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2006-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.binding.utils
{

import mx.binding.utils.ChangeWatcher;

/**
 *  The BindingUtils class defines utility methods
 *  for performing data binding from ActionScript.
 *  You can use the methods defined in this class to configure data bindings.
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public class BindingUtils
{

    public static function bindProperty(
                                site:Object, prop:String,
                                host:Object, chain:Object,
                                commitOnly:Boolean = false,
                                useWeakReference:Boolean = false):ChangeWatcher
    {
        var w:ChangeWatcher =
            ChangeWatcher.watch(host, chain, null, commitOnly, useWeakReference);
        
        if (w != null)
        {
            var assign:Function = function(event:*):void
            {
                site[prop] = w.getValue();
            };
            w.setHandler(assign);
            assign(null);
        }
        
        return w;
    }

    public static function bindSetter(setter:Function, host:Object,
                                      chain:Object,
                                      commitOnly:Boolean = false,
                                      useWeakReference:Boolean = false):ChangeWatcher
    {
        var w:ChangeWatcher =
            ChangeWatcher.watch(host, chain, null, commitOnly, useWeakReference);
        
        if (w != null)
        {
            var invoke:Function = function(event:*):void
            {
                setter(w.getValue());
            };
            w.setHandler(invoke);
            invoke(null);
        }
        
        return w;
    }
}

}
