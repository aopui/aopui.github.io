////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Oct 18, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui
{
	import client.mainui.MainUIMediator;
	import client.mainui.view.panel.BottomPanel;
	import client.model.Model;
	
	import com.aopui.admiral.CursorAdmiral;
	import com.aopui.admiral.LayoutAdmiral;
	import com.aopui.admiral.PopupAdmiral;
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.admiral.StateAdmiral;
	import com.aopui.admiral.ToolTipAdmiral;
	import com.aopui.event.EventBase;
	import com.aopui.model.GlobalModel;
	import com.aopui.sdk.app.Application;
	import com.aopui.sdk.module.ModuleInfo;
	import com.aopui.ui.BasicUI;
	import com.aopui.ui.GameScene;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.LoaderContext;
	import flash.ui.Keyboard;
	
	import mx.binding.utils.BindingUtils;
	
	public class Marshal
	{
		
		private var _loaderLayer:Sprite;
		private var _stateEffectLayer:Sprite;
		private var _toolTipLayer:Sprite
		private var _cursorLayer:Sprite;
		private var _popupLayer:Sprite;
		private var _uiLayer:Sprite;
		private var _sceneLayer:Sprite;		
		
		[Inject]
		public var model:Model;
		[MessageDispatcher]
		public var dispather:Function;
		
		[Inject]
		public var mainui:MainUIMediator;
		
		public function get popupLayer():Sprite
		{
			return _popupLayer;
		}

		public function get toolTipLayer():Sprite
		{
			return _toolTipLayer;
		}
		public function set toolTipLayer(value:Sprite):void
		{
			_toolTipLayer = value;
		}

		public function set popupLayer(value:Sprite):void
		{
			_popupLayer = value;
		}
		
		public function Marshal()
		{
			_uiLayer = new Sprite();
			_sceneLayer = new Sprite();
			_popupLayer  =new Sprite();
			_cursorLayer = new Sprite();
			_toolTipLayer=new Sprite();	
			_stateEffectLayer=new Sprite();
			_cursorLayer.mouseEnabled = false;
			_cursorLayer.mouseChildren = false;
		}
		
		[Init]
		public function initializ():void
		{
			Application.app.scene.stage.addEventListener(Event.RESIZE,onResize);
			Application.app.scene.stage.addChild(_sceneLayer);
			Application.app.scene.stage.addChild(_uiLayer);			
			Application.app.scene.stage.addChild(_popupLayer);
			Application.app.scene.stage.addChild(_cursorLayer);
			Application.app.scene.stage.addChild(_toolTipLayer);
			Application.app.scene.stage.addChild(_stateEffectLayer);
			PopupAdmiral.popupLayer=_popupLayer;
			CursorAdmiral.cursorLayer=_cursorLayer;
			CursorAdmiral.gameLayer=_sceneLayer;
			ResourceAdmiral.init(ModuleInfo.loaderContext.applicationDomain,GlobalModel.assetspre+".");
			ToolTipAdmiral.init(_toolTipLayer,[_uiLayer,_popupLayer]);
			LayoutAdmiral.scene=_sceneLayer;
			StateAdmiral.stateEffectLayer=_stateEffectLayer;
			BasicUI._model=model;
			GameScene._model=model;
			BasicUI._dispather=dispather;
			BindingUtils.bindProperty(this,"state",model,"state");
			initDefaultShortcut(Application.app.scene.stage);
			init();
		}
		public function initDefaultShortcut(stage:Stage):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,shortcutHandler);
		}
		
		public function shortcutHandler(e:KeyboardEvent):void
		{
			if(!e.ctrlKey)
				return;
			switch(e.keyCode)
			{
				case Keyboard.F11:
					LayoutAdmiral.changeSence();
				default:
					break;
			}
		}
		
		private function onResize(e:Event):void
		{
			for(var i:int=0;i<_uiLayer.numChildren;i++)
			{
				var child:Object=uiLayer.getChildAt(i);
				if(child is BasicUI)
				{
					child.invalidate();
				}
//				else if(child is BottomPanel)
//				{
//					
//					LayoutAdmiral.layout(child);
//				}
			}
			var o:Object
			if(o)
				o.invalidate();
			for (i=0;i<this.popupLayer.numChildren;i++)
			{
				o=popupLayer.getChildAt(i);
				if(o is BasicUI)
				{
					o.showInCenter();
					o.invalidate();
				}
			}
			if(_sceneLayer.numChildren<1)
				return;
			o=_sceneLayer.getChildAt(0);
			
		}
		
		public function set state(o:Object):void
		{
//			StateAdmiral.excute();
			doSetState(_uiLayer)
			mainui.onStateChanged(model.state);
		}
		private function doSetState(container:Sprite):void
		{
			for(var i:int=0;i<container.numChildren;i++)
			{
				var child:Object=container.getChildAt(i);
				if(child is BasicUI)
				{
					if(child.state!="")
					{						
						if(child.state.indexOf(model.state)!=-1)
						{							
							child.visible=true;
						}
						else
						{
							child.visible=false;
						}
						
						Object(child).stateChange(child.state);
					}
					doSetState(child as Sprite);
				}
			}
		}
		
		public function get uiLayer():Sprite
		{
			return _uiLayer;
		}
		
		public function get sceneLayer():Sprite
		{
			return _sceneLayer;
		}

		public function get cursorLayer():Sprite
		{
			return _cursorLayer;
		}
		
		public function showLoadingTxt(txt:String):void
		{
			this.sceneLayer.stage.dispatchEvent(EventBase.createEvent("showLoadingTxt",{txt:txt}));
		}
		public  function init():void
		{
//			mainui.init();
			TweenMax.delayedCall(.5,mainui.init);
		}
	}
}