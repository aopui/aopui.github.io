package com.aopui.ui
{
	import com.aopui.model.GlobalModel;
	
	import flash.display.Sprite;
	
	public class GameScene extends Sprite
	{
		public static var _model:GlobalModel
		public function GameScene()
		{
			super();
		}
		
		public static function get model():GlobalModel
		{
			return _model;
		}

		public static function set model(value:GlobalModel):void
		{
			_model = value;
		}

		public function layout():void
		{
			
		}
	}
}