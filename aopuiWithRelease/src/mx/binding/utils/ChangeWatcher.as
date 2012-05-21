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
    
import flash.events.IEventDispatcher;
import flash.events.Event;
import mx.binding.BindabilityInfo;
import mx.events.PropertyChangeEvent;
import mx.utils.DescribeTypeCache;

public class ChangeWatcher
{
    public static function watch(host:Object, chain:Object,
                                 handler:Function,
                                 commitOnly:Boolean = false,
                                 useWeakReference:Boolean = false):ChangeWatcher
    {
        if (!(chain is Array))
            chain = [ chain ];

        if (chain.length > 0)
        {
            var w:ChangeWatcher =
                new ChangeWatcher(chain[0], handler, commitOnly,
                    watch(null, chain.slice(1), handler, commitOnly));
            w.useWeakReference = useWeakReference;
            w.reset(host);
            return w;
        }
        else
        {
            return null;
        }
    }

    public static function canWatch(host:Object, name:String,
                                    commitOnly:Boolean = false):Boolean
    {
        return !isEmpty(getEvents(host, name, commitOnly));
    }

   
    public static function getEvents(host:Object, name:String,
                                     commitOnly:Boolean = false):Object
    {
        if (host is IEventDispatcher)
        {

            var allEvents:Object = DescribeTypeCache.describeType(host).
                                   bindabilityInfo.getChangeEvents(name);
            if (commitOnly)
            {
                // Filter out non-committing events.
                var commitOnlyEvents:Object = {};
                for (var ename:String in allEvents)
                    if (allEvents[ename])
                        commitOnlyEvents[ename] = true;
                return commitOnlyEvents;
            }
            else
            {
                return allEvents;
            }
        }
        else
        {
           
            return {};
        }
    }


    private static function isEmpty(obj:Object):Boolean
    {
        for (var p:String in obj)
        {
            return false;
        }
        return true;
    }


    public function ChangeWatcher(access:Object, handler:Function,
                                  commitOnly:Boolean = false,
                                  next:ChangeWatcher = null)
    {
        super();

        host = null;
        name = access is String ? access as String : access.name;
        getter = access is String ? null : access.getter;
        this.handler = handler;
        this.commitOnly = commitOnly;
        this.next = next;
        events = {};
        useWeakReference = false;
        isExecuting = false;
    }

    private var host:Object;


    private var name:String;


    private var getter:Function;


    private var handler:Function;


    private var commitOnly:Boolean;


    private var next:ChangeWatcher;


    private var events:Object;

    private var isExecuting:Boolean;

    public var useWeakReference:Boolean;

    public function unwatch():void
    {
        reset(null);
    }

    public function getValue():Object
    {
        return host == null ?
               null :
               next == null ?
               getHostPropertyValue() :
               next.getValue();
    }

    public function setHandler(handler:Function):void
    {
        this.handler = handler;
        if (next)
            next.setHandler(handler);
    }

    public function isWatching():Boolean
    {
        return !isEmpty(events) && (next == null || next.isWatching());
    }

    public function reset(newHost:Object):void
    {
        var p:String;

        if (host != null)
        {
            for (p in events)
            {
                host.removeEventListener(p, wrapHandler);
            }
            events = {};
        }

        host = newHost;

        if (host != null)
        {
            events = getEvents(host, name, commitOnly);
            for (p in events)
            {
                host.addEventListener(p, wrapHandler, false,
                    /*EventPriority.BINDING*/100, useWeakReference);
            }
        }

        if (next)
            next.reset(getHostPropertyValue());
    }

    private function getHostPropertyValue():Object
    {
        return host == null ? null : getter != null ? getter(host) : host[name];
    }

    private function wrapHandler(event:Event):void
    {
        if (!isExecuting)
        {
            try
            {
                isExecuting = true;

                if (next)
                    next.reset(getHostPropertyValue());

                if (event is PropertyChangeEvent)
                {
                    if ((event as PropertyChangeEvent).property == name)
                        handler(event as PropertyChangeEvent);
                }
                else
                {
                    handler(event);
                }
            }
            finally
            {
                isExecuting = false;
            }
        }
    }

}

}
