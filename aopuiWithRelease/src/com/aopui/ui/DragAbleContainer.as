package com.aopui.ui
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class DragAbleContainer extends Panel
	{
		public function DragAbleContainer()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMDown);
			this.addEventListener(MouseEvent.MOUSE_UP,onMUp);
		}
		public var isDown:Boolean=false;
		public static var isMoved:Boolean=false;
		public var oldx:Number;
		public var interactive:Boolean=true;
		
		public static var isMoveing:Boolean=false;
		private function onMDown(e:Event):void{
			if(!interactive)
				return;
			isDown=true;
			oldx=this.mouseX;
			
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);			
		}
		
		private function onMouseMove(e:Event):void
		{
			isMoved=true;
			if(!this.hasEventListener(Event.ENTER_FRAME))
			{
				
				addE();
				
			}
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		
		private function addE():void{
			
			addEventListener(Event.ENTER_FRAME,onEnterframe);
		}
		
		private function onMUp(e:Event):void
		{
			isDown=false;
			isMoved=false;
		}
		private var dx:Number=0;
		private var dr:Number;
		private function onEnterframe(e:Event):void		
		{
			if(!interactive)
				return;
			isMoveing=true;
			if(isDown)
			{
				dx = oldx-this.mouseX;			
				dr=this.horizonPosition2-dx;
				oldx=this.mouseX;
			}
			else
			{
				if( dx != -1 )
				{
					dx= (dr+dx*10-this.horizonPosition2)*.08
					
					if( Math.ceil( (dr+dx) ) == Math.ceil( this.horizonPosition2 ) )
					{
						dx = -1;
						this.removeEventListener(Event.ENTER_FRAME, onEnterframe );
						isMoveing=false;
						this.parent.rotationY=0;
					}						
					dr-=dx;					
				}
				
			}
			if(isNaN(dr))
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterframe );
				isMoveing=false;
				this.parent.rotationY=0;
				return;
			}
			if(dx==0)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterframe );
				isMoveing=false;
				this.parent.rotationY=0;
				return;
			}
			
			if(dx==-1)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterframe );
				isMoveing=false;
				this.parent.rotationY=0;
				return;
			}
			this.horizonPosition2=dr;
			if(this.showAbleSpace.width-this.width<-this.horizonPosition2-minContentRight)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterframe );
				isMoveing=false;
				this.parent.rotationY=0;
				if(!ignoreContentLR)
				this.horizonPosition2=-(this.showAbleSpace.width-this.width+minContentRight);
			}
			if(0>-this.horizonPosition2+minContentLeft)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterframe );
				isMoveing=false;
				this.parent.rotationY=0;
				if(!ignoreContentLR)
				this.horizonPosition2=minContentLeft;
			}
			
			
		}
		public function reset():void
		{
			oldx=0
			if(this.hasEventListener(MouseEvent.MOUSE_MOVE))
				this.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			if(this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME,onEnterframe);
		}

		
		public function onMouseDown(e:Event):void
		{
			this.horizonPosition2=1;
		}
	}
}