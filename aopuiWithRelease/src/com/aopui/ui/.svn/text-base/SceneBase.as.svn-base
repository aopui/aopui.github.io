////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Aug 24, 2010
//  @author wushihuan
//	emial:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class SceneBase extends ContainBase
	{
		private var _tipLayer:Sprite;
		private var _popupLayer:Sprite;
		private var _skinLayer:Sprite;		
		private var _gameLayer:Sprite;
		public function SceneBase()
		{
			super();
			super.addChild(_gameLayer);
			super.addChild(_skinLayer);
			super.addChild(_popupLayer);
			super.addChild(_tipLayer);
		}
		
		public function addSkin(s:DisplayObject):void
		{
			_skinLayer.addChild(s);
		}
		
		public function addpopup(s:DisplayObject):void
		{
			_popupLayer.addChild(s);
		}
		public function addTip(s:DisplayObject):void
		{
			_tipLayer.addChild(s);
		}
		
		public function addGameObject(s:DisplayObject):void
		{
			_gameLayer.addChild(s);
		}
		
		
	}
}