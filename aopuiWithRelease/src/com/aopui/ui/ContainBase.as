/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui
{
	import com.aopui.core.ContentLayer;
	import com.aopui.core.ContentSpace;
	import com.aopui.effect.page.IPageEffect;
	import com.aopui.effect.page.ListPageEffect;
	import com.aopui.event.ContainEvent;
	import com.aopui.event.EventBase;
	import com.aopui.ui.list.ListBase;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ContainBase extends BasicUI
	{
		
		public var contentSpace:Sprite=new ContentLayer();
		public var itemWidth:Number;
		
		protected var rectW:Number;
		protected var rectH:Number;
		protected var rectX:Number;
		protected var rectY:Number;
		
		public var navigationPreWidth:Number=0;
		public var navigationPreHeight:Number=0;
		public var navigationVGap:Number=0;	
		public var navigationHGap:Number=0;
		private var _needMask:Boolean=true;
		private var _pageEffect:IPageEffect;
		
		public var showAbleSpace:Sprite=new ContentLayer();
		
		private var _content:Object;
		private var _contentDesc:Object;
		public function ContainBase()
		{
			super();
			super.addChild(contentSpace);
			this.contentSpace.scrollRect=new Rectangle(0,0,1,1);
			containAddChild(showAbleSpace);
			navigation=true;
		}

		public function get pageEffect():IPageEffect
		{
			return _pageEffect;
		}

		public function set pageEffect(value:IPageEffect):void
		{
			
			value.contain=this;
			if(_pageEffect)_pageEffect.remNavigation();
			_pageEffect = value;
			if(_navigation)_pageEffect.addNavigation();
		}

		public function get needMask():Boolean
		{
			return _needMask;
		}

		public function set needMask(value:Boolean):void
		{
			_needMask = value;
		}

//		private function onContentChange(e:EventBase):void
//		{
//			this.reDrawMask();
//		}
		
		private var _navigation:Boolean=false;
		public function set navigation(v:Boolean):void
		{
			_navigation=v;
			if(_navigation)
			{
				addNavigation();
			}
			else
			{
				remNavigation();
			}
		}
		
		public function get navigation():Boolean
		{
			return _navigation;
		}
		
		private function addNavigation():void
		{
			if(_pageEffect)
				_pageEffect.addNavigation();
		}
		
		private function remNavigation():void
		{
			if(_pageEffect)
				_pageEffect.remNavigation();
		}
		
//		//当显示区域变化时候重新绘制mask
//		public function reDrawMask():void
//		{
//			
//		}
		
		override protected function layoutSelfSize():void
		{
			
			// 确定 contentSpace的大小
			var showAbleSpaceRect:Rectangle;
			showAbleSpaceRect=this.getBounds(this.showAbleSpace);
			if(this.widthChanged)
			{
				if(_pageEffect)
				{
					rectW=this.width-_pageEffect.getVerticalScrollBarW();
				}
				else
				{
					rectW=this.width;
					if(showAbleSpaceRect.right-showAbleSpaceRect.left>rectH)
						rectH=showAbleSpaceRect.right-showAbleSpaceRect.left+10;
				}
			}
			else
			{
				rectW=this.showAbleSpace.width;
				
			}
			
			if(this.heightChanged)	
			{
				if(_pageEffect)
				{
					rectH=this.height-_pageEffect.getHorizonScrollBarH();
				}
				else
				{
					rectH=this.height;
					
					if(showAbleSpaceRect.bottom-showAbleSpaceRect.top>rectH&&!cancalRect)
						rectH=showAbleSpaceRect.bottom-showAbleSpaceRect.top;
				}
			}
			else
			{
				rectH=this.showAbleSpace.height;
				
			}
			
			if(this.width<rectW)
				this.width=rectW;
			if(this.height<rectH)
				this.height=rectH;
			if(cancalRect)
				contentSpace.scrollRect=null;	
			if(!this.cancalRect)
				this.contentSpace.scrollRect=new Rectangle(0,0,rectW,rectH);
			if(_pageEffect)
				_pageEffect.layout();
		}
		
		
		override protected function layoutSize():void
		{
			
			super.layoutSize();
			var i:int=0;
			var disp:DisplayObject;
			while(i<contentSpace.numChildren)
			{
				disp=contentSpace.getChildAt(i);
				if(disp is BasicUI)
				{
					BasicUI(disp).layout();
				}
				i++;
			}
			i=0;
			while(i<showAbleSpace.numChildren)
			{
				disp=showAbleSpace.getChildAt(i);
				if(disp is BasicUI)
				{
					BasicUI(disp).layout();
				}
				i++;
			}
			
			i=0;
			while(i<contentLayer.numChildren)
			{
				disp=contentLayer.getChildAt(i);
				if(disp is BasicUI)
				{
					BasicUI(disp).layout();
				}
				i++;
			}
		}
		
		override protected function layoutPosition():void
		{
			super.layoutPosition();
			this.contentSpace.x=rectX;
		}
		
		
		
		override public function layout():void
		{
			super.layout();
			
			//这里有个bug 在 showAbleSpace种的控件先布局时 ,当前的宽和高都是老的宽个高  这时候如果被布局的原件含有gloabelAligin属性  ,这个属性将会被计算错误
			//怎么样避免这个问题 。。。
			//布局也要分步骤 
			/*1.先布局  自身的 大小    
			 *2.布局子控件的大小更新父原件的 大小（这里要凑策略 1.没有设置大小的 
																	就可以直接扩大
														    2.没有设置pageEffect的 就必须得设置大小啊 
																	
															
												）
			 *2.布局位置  (含有gloabelAligin属性的控件 会被父容器的大小所影响)
			 *3.完成布局
			 */
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			this.showAbleSpace.addChild(child);
			if(child is BasicUI)
				BasicUI(child).parentui=this;
			return child;
		}
		
		
		override public function getChildAt(index:int):DisplayObject
		{
			return this.showAbleSpace.getChildAt(index);
		}
		
		override public function getChildIndex(child:DisplayObject):int
		{
			return this.showAbleSpace.getChildIndex(child);
		}
		
		override public function get numChildren():int
		{
			return this.showAbleSpace.numChildren;
		}
		
		
		private var _horizonPosition:Number;
		
		/**
		 *以百分比得形式显示区域
		 * value 0显示最左边范围  1显示到最右边范围
		 **/
		public function set horizonPosition(value:Number):void
		{
			var w:Number=this.showAbleSpace.width-this.width;
			_horizonPosition=value;
			w*=value;
			this.showAbleSpace.x=-w;
		}
		
		/**
		 * 设置坐标
		 **/
		public function set horizonPosition2(value:Number):void
		{
			this.showAbleSpace.x=value;
		}
		
		public function get horizonPosition2():Number
		{
			return this.showAbleSpace.x;
		}
		
		
		public function get horizonPosition():Number
		{
			var w:Number=this.showAbleSpace.width-this.width;
			_horizonPosition=(-this.showAbleSpace.x)/w;			
			return _horizonPosition;	
		}
		
		private var _verticalPosition:Number
		
		/**
		 *以百分比得形式显示区域
		 * value 0显示最上边范围  1显示到最下边范围
		 **/
		public function set verticalPosition(value:Number):void
		{			
			var w:Number=this.showAbleSpace.height-this.height;
			_verticalPosition=value;
			w*=value;
			this.showAbleSpace.y=-w;
		}
		
		/**
		 * 设置坐标
		 **/
		public function set verticalPosition2(value:Number):void
		{
			this.showAbleSpace.y=value;
		}
		public function get verticalPosition2():Number
		{
			return this.showAbleSpace.y;
		}
		
		
		public function containAddChild(child:DisplayObject):DisplayObject
		{
			var dis:DisplayObject=contentSpace.addChild(child);
//			this.dispatchEvent(EventBase.createEvent(ContainEvent.CONTENT_CHANGE,{type:"+"}));
			return dis;
		}
		
		public function containRemoveAllChild():void
		{
			removeTargetAllChild(contentSpace);
//			this.dispatchEvent(EventBase.createEvent(ContainEvent.CONTENT_CHANGE,{type:"--"}));			
		}
		
		public function containRemoveChild(child:DisplayObject):DisplayObject
		{
			var dis:DisplayObject=contentSpace.removeChild(child);
//			this.dispatchEvent(EventBase.createEvent(ContainEvent.CONTENT_CHANGE,{type:"-"}));
			return dis;
		}

		public function get content():Object
		{
			return _content;
		}

		public function set content(value:Object):void
		{
			_content = value;
		}
		
		

		public function get contentDesc():Object
		{
			return _contentDesc;
		}

		public function set contentDesc(value:Object):void
		{
			_contentDesc = value;
			content=analyseContent(value);
		}
		
		private function analyseContent(value:Object):Object
		{
			for(var s:String in value)
			{
				var cls:Class;
				
//				if(!cls)continue;
				var instance:Object
				if(value[s] is Array)
				{
					for each(var o:Object in value[s])
					{
						cls=getUI("com.aopui.ui."+s);
						instance=new cls();
						applyPro(value,o,instance);
					}
				}
				else
				{
					cls=getUI("com.aopui.ui."+s);
					instance=new cls();
					applyPro(value,value[s],instance);
				}				
			}
			return null;
		}
		
		private function applyPro(contentdesc:Object,compontDescObject:Object,instance:Object):void
		{
			for(var pro:String in compontDescObject)
			{
				switch(pro)
				{
					case "id":
						Object(this)[compontDescObject[pro]]=instance;
						break;
					case "buttonSkinClass":
						instance.buttonSkinClass=getUI(compontDescObject[pro]);
						break;
					case "renderClass":
						instance.renderClass=getUI("com.aopui.ui."+compontDescObject[pro]);
						break;
					case "eventListener":
						instance.addEventListener(compontDescObject[pro][0]+"",compontDescObject[pro][1]);
						break;
					case "skinClass":
						instance.skinClass=getUI(compontDescObject[pro]);
						break;
					case "icon":
						instance.icon=getUI(compontDescObject[pro]);
						break;
					case "text":
						instance.text=compontDescObject[pro];
						break;
					case "label":
						instance.label=compontDescObject[pro];
						break;
					case "children":
						for each(var _proName:String in compontDescObject[pro])
						{
							var child:Object=Object(this)[_proName+""];
							if(!child)break;
							instance.addChild(child);
						}
						break;
					case "parent":
						var parent:Object=Object(this)[compontDescObject[pro]];
						if(!parent)break;
						parent.addChild(instance);
						break;
					default:
						break;
				}					
			}
			if(compontDescObject.noParent)
				return;
			this.addChild(instance as DisplayObject);
			
		}
		


	}
}