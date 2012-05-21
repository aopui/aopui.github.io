package com.aopui.admiral
{
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	
	import mx.controls.Tree;

	public class CameraAdmiral
	{
		
		private var video:Video;
		private var camera:Camera;
		private var mw:int;
		private var mh:int;
		private var fps:int;
		private var videow:int;
		private var videoh:int;
		public function CameraAdmiral(mw:int=640,mh:int=480,videow:int=640,videoh:int=480,fps:int=10)
		{
			this.videow=videow;
			this.videoh=videoh;
			camera=Camera.getCamera("0");
			this.mw=mw;
			this.mh=mh;
			this.fps=fps;
			if(!camera)
				return;
			camera.setMode(mw,mh,fps);

			
		}
		
		/**
		 * 把video放到某个容器
		 * @param sprite 放video的容器
		 * 
		 */
		public function addVideoTo(sprite:Sprite):Video
		{
			video=new Video(videow,videoh);
			sprite.addChild(video);
			return video;
		}
		
		
		/**
		 * 返回拍的照片
		 * @param photoW 返回图像的宽
		 * @param photoH 返回图像的高
		 * @return 
		 * 
		 */
		public function makePhoto(photoW:Number=640,photoH:Number=480):BitmapData
		{
			var bd:BitmapData = new BitmapData(photoW,photoH);
			var myMatrix:Matrix=new Matrix();
			myMatrix.scale(photoW/video.width,photoW/video.width);//关键处，该处的值应该是由video的大小和camera设置的大小决定的。
			bd.draw(video,myMatrix);
			return bd;
		}
		
		/**
		 *播放摄像机捕捉的视频给video 
		 * 
		 */
		public function playVideo():void
		{
			if(!camera)
				return;
			isStoped=false;
			video.attachCamera(camera);
				TweenMax.delayedCall(
					1.5,function():void
					{
						video.visible=true;
					}
				);
		}
		
		public function clearVideo():void
		{
			if(!video)
				return;
			video.visible=false;
			video.clear();
			var s:Sprite=video.parent as Sprite;
			s.removeChild(video);
			video=null;
		}
		
		public var isStoped:Boolean=false;
		public function stopVideo():void
		{
			if(!video)
				return;
			video.attachCamera(null);
			
			isStoped=true;
		}
	}
}