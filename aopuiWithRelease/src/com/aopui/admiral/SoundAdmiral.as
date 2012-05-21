package com.aopui.admiral
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class SoundAdmiral
	{
		
		private static var sounds:Dictionary=new Dictionary();
		public function SoundAdmiral()
		{
		}
		
		private static function getSoundTransform(value:Number):SoundTransform
		{
			
			if(soundTs[value])
			{	
				return soundTs[value];
			}	
			
			var st:SoundTransform=new SoundTransform(value);
			soundTs[value]=st;
			return st;
		}
		private static var soundTs:Dictionary=new Dictionary();
		
		public static function playSound(path:String,vol:Number=1,lop:int=0,start:Number=0):void
		{	
			if(sounds[path])
			{
				sounds[path].play();
				return;
			}			
			var s:Sound = new Sound();
			sounds[path]=s;
			
//			s.addEventListener(Event.COMPLETE, onSoundLoaded);
			var req:URLRequest = new URLRequest(path);
			s.load(req);
			s.play(start,lop,getSoundTransform(vol));
		}
;
		
		private static  function onSoundLoaded(event:Event):void
		{
			
			var localSound:Sound = event.target as Sound;
			localSound.removeEventListener(Event.COMPLETE,onSoundLoaded);
			localSound.play();
		}
	}
}