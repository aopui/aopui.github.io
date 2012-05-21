/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui.list
{
	import com.aopui.admiral.ArrayAdmiral;
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.ui.BasicUI;
	import com.aopui.ui.ContainBase;
	import com.aopui.ui.List;
	import com.aopui.ui.txt.TxtBase;
	
	import flash.display.DisplayObject;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.engine.GroupElement;
	import flash.text.engine.RenderingMode;
	
	[Event(type="com.aopui.event.GroupEvent",name="group_click")]
	public class ListBase extends ContainBase
	{
		private var _horizonGap:Number=0;
		private var _verticalGap:Number=0;
		public var points:Array;
		
		public var renderWidth:Number=0;
		public var renderHeight:Number=0;
		
		[ArrayElementType("flash.display.DisplayObject")]
		public var randers:Array=[];
		
		public var listTypes:Array=["list","bar","tile"];
		//list的类型
		private var _listType:String=listTypes[0];
		protected var _data:Object;
		private var _randerSkinClass:Class;
		
		public var pageIndex:int=0;
		public var renderParam:Object;
		
		public var renderMarginTop:Number=0;
		public var renderMarginLeft:Number=0;
		public var renderAutoSize:Boolean=false;
		

		
		
		
		
		public function ListBase()
		{
			super();
			listen();
		}		
		
		override public function set verticalGap(value:Number):void
		{
			_verticalGap=value;
		}
		
		override public function get verticalGap():Number
		{
			return _verticalGap;
		}
		
		override public function set horizonGap(value:Number):void
		{
			_horizonGap=value;
		}
		
		override public function get horizonGap():Number
		{
			return _horizonGap;
		}
		
		
		override public function set marginTop(value:Number):void
		{
			_marginTop=value;
		}
		override public function get marginTop():Number
		{
			return _marginTop;
		}
		
		override public function set marginLeft(value:Number):void
		{
			_marginLeft=value;
		}
		override public function get marginLeft():Number
		{
			return _marginLeft;
		}
		
		override public function get font():Object
		{
			return _font;
		}

		override public function set font(value:Object):void
		{
			_font = value;
		}

		public function get listType():String
		{
			return _listType;
		}
		
		[Inspectable(enumeration="list","bar","tile")]
		public function set listType(value:String):void
		{
			_listType = value;
		}

		public function getPageSize():int
		{
			if(listType==listTypes[0])
			{
				
			}
			return 100;
		}
		public function getPages():int
		{
			var pageSize:int=getPageSize();
			var pages:int=_data.length/pageSize;
			if(_data.length%pageSize>1)pages++;
			return pages;
		}
		
		protected function listen():void
		{
			this.addEventListener(MouseEvent.CLICK,groupClickHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			this.addEventListener(GroupEvent.GROUP_CLICK, onGroupClick);
			this.addEventListener(GroupEvent.Group_OVER,onGroupOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN,groupDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,groupUpHandler);
		}
		protected function onMouseOut(e:Event):void
		{
			if(!needOverEffect)
				return;
			if(!_renderClass)return;
			var target:Object=isRenderClass(e.target);
			if(target is _renderClass)
			{
				var r:RenderBase=RenderBase(target);
				r.onOut();
				dispatchEvent(EventBase.createEvent(GroupEvent.Group_OUT,{target:r,index:r.index,data:r.data}));
			}
		}
		
		protected function onMouseOver(e:Event):void
		{
			if(!needOverEffect)
				return;
			if(!_renderClass)return;
			var target:Object=isRenderClass(e.target);
			if(target is _renderClass)
			{	
				var r:RenderBase=RenderBase(target);
				r.onOver();
				dispatchEvent(EventBase.createEvent(GroupEvent.Group_OVER,{target:r,index:r.index,data:r.data}));
			}
		}
		
		protected function groupClickHandler(e:Event):void
		{
			if(!_renderClass)return;
			var target:Object=isRenderClass(e.target);
			if(target is _renderClass)
			{	
				if(!target.mouseEnabled)
					return;
				var r:RenderBase=RenderBase(target);
				if(r.selected)return;
				dispatchEvent(EventBase.createEvent(GroupEvent.GROUP_CLICK,{target:r,index:r.index,data:r.data}));
				r.onClick();
			}
		}
		
		protected function groupDownHandler(e:Event):void
		{
			return;
			
			if(!_renderClass)return;
			e.stopImmediatePropagation();
			e.stopPropagation();
			var target:Object=isRenderClass(e.target);
			var r:RenderBase
			var index:Object
			var data:Object;
			if(target is _renderClass)
			{	
				r=RenderBase(target);
				index=r.index;
				data=r.data;
			}
			
			dispatchEvent(EventBase.createEvent(GroupEvent.GROUP_DOWN,{target:r,index:index,data:data}));
		}
		
		protected function groupUpHandler(e:Event):void
		{
			return;
			if(!_renderClass)return;
			e.stopImmediatePropagation();
			e.stopPropagation();
			var target:Object=isRenderClass(e.target);
			var r:RenderBase
			var index:Object
			var data:Object;
			if(target is _renderClass)
			{	
				r=RenderBase(target);
				index=r.index;
				data=r.data;
			}
		
			dispatchEvent(EventBase.createEvent(GroupEvent.Group_UP,{target:r,index:index,data:data}));
		}
		
		private function isRenderClass(o:Object):Object
		{
			if(!o)return null;
			var p:Object=o;
			if(p is _renderClass)return p;
			while(p.parent)
			{
				if(p is _renderClass)return p;
				p=p.parent;
			}
			return o;
		}
		
		public function get randerSkinClass():Class
		{
			return _randerSkinClass;
		}

		public function set randerSkinClass(value:Class):void
		{
			_randerSkinClass = value;
		}

		override public function set renderClass(cls:Class):void
		{
			_renderClass=cls;
		}
		
		override public function get renderClass():Class
		{
			return _renderClass;
		}
		
		/**
		 * 列表的宽是根据
		 * render的个数,render的width和horizonGap,navigationPreWidth决定来list的宽度
		 * render的height和navigationPreHeight决定list的高度
		 * 
		 * List的效果问题		 * 
		 * 		设置scrollRect 多创建几个render来符合缓动效果条件
		 * 翻页的问题   必须可以把list的所有数值都一下子付给list		
		 * 		每次翻页先创建好所需要的所有render
		 * 		点击翻页的时候将这些先创建好的render缓动到scrollRect的显示区域
		 */
		
		public function createRender():void
		{
			var defaultLength:int=0;
			randers=[];
			var pageData:Array=getCurrentPageData(pageIndex);			
			defaultLength=pageData.length;
			if(defaultLength>pageSize)defaultLength=pageSize;
			var rander:RenderBase;
			for(var i:int=0;i<defaultLength;i++)
			{
				rander=new _renderClass();
				if((rander is TxtBase)&& this._font)
				{
					Object(rander)["font"]=_font;
				}
				
				rander.index=i+pageIndex*pageSize;
				rander.currentPageLength=defaultLength;
				rander.maxLength=this.data.length;
				if(_randerSkinClass)rander.skinClass=_randerSkinClass;
				if(renderParam)
					rander.setParam(renderParam);
				if(Object(rander).hasOwnProperty("autoSize"))
				{
					Object(rander).autoSize=this.renderAutoSize;
					Object(rander).marginLeft=this.renderMarginLeft;
				}
				rander.parentui=this;
				addRenderChild(rander);
				randers.push(rander);
				rander.data=pageData[i];
				this.renderHeight=rander.height;
				this.renderWidth=rander.width;
			}
			if(listType==listTypes[0])return;
			return;
//			pageSize=100;
//			for(i=0;i<pageSize-defaultLength;i++)
//			{
//				rander=new _renderClass();
//				rander.index=defaultLength+i;
//				if(_randerSkinClass)rander.skinClass=_randerSkinClass;
//				if(renderParam)
//					rander.setParam(renderParam);
//				
////				if(Object(rander).hasOwnProperty("autoSize"))
////				{
////					Object(rander).autoSize=this.renderAutoSize;
////					Object(rander).marginLeft=this.renderMarginLeft;
////				}
//				containAddChild(rander);
//
//				randers.push(rander);
//				rander.data=pageData[i];
//			}
		}
		public function removeRenderAt(index:int):void
		{
			for each(var r:RenderBase in this.randers)
			{
				if(r.index==index)
				{
					r.parent.removeChild(r);
					this.randers.splice(this.randers.indexOf(r),1);
					return;
				}
			}
		}
		public function getCurrentPageData(pageIndex:int):Array
		{
			var pageData:Array=[];
			var startIndex:int=pageSize*pageIndex;
			var endIndex:int=pageSize*pageIndex+pageSize;
			if(endIndex>_data.length)endIndex=_data.length;
			for(var pi:int=startIndex;pi<endIndex;pi++)
			{
				pageData.push(_data[pi]);
			}
			return pageData;
		}
		
		
//		override public function reDrawMask():void
//		{
//			if(!needMask)return;
			
			
			
//			contentMask.graphics.clear();
//			contentMask.graphics.beginFill(0xffffff);
//			var r:Rectangle=getBounds(contentLayer);
//			var maskWidth:Number=r.right-r.left;
//			if(maskWidth>width-2*(marginLeft-1))maskWidth=width-2*(marginLeft-1);
//			contentMask.graphics.drawRect(marginLeft-1,marginTop-1,maskWidth,r.bottom-r.top-marginTop+1);
//			contentMask.graphics.endFill();
//			contentLayer.mask=contentMask;
//		}
		protected function get visibleRanders():Array
		{
			var arr:Array=[];
//			var i:int=0;
			for each(var o:Object in randers)
			{
//				o.index=i;
				if(o.visible)
					arr.push(o);
//				i++;
			}
			return arr;
		}
		
		public function switchRender(index1:int,index2:int,direction:String="H"):void
		{
			ArrayAdmiral.switchItem(randers,index1,index2);	
			this.layout();
		}
		
		protected function HLayout():void
		{
			this.points=[];
			var visibleR:Array=visibleRanders;
			for(var i:int=0;i<visibleR.length;i++)
			{
//				visibleR[i].index=randers.indexOf(visibleR[i]);
				var rander:DisplayObject=visibleR[i] as DisplayObject;
				var preWidth:Number=.0;
				var prex:Number=.0;
				var usedHhorizonGap:Number=.0;
				if(i>0)
				{
					var rect:Rectangle=visibleR[i-1].getBounds(visibleR[i-1]);
					preWidth=visibleR[i-1].width+rect.left;
					prex=visibleR[i-1].x;
					usedHhorizonGap=horizonGap;
				}
				if(this is List)
				{
					rander.x=preWidth+prex+usedHhorizonGap;
					if(horizonAlign=="center")
						this.rectW=rander.x+rander.width;
				}
				else
				{
					rander.x=marginLeft+preWidth+prex+usedHhorizonGap;
					rander.y=marginTop;
					switch(verticalAlign)
					{
						case "center":
							rander.y=this.$height/2-rander.height/2;
							break;
						case "top":
							rander.y=marginTop;
							break;
						case "bottom":
							rander.y=this.$height-rander.height;
							break;
					}
					this.width=rander.x+rander.width;					
				}
				points.push({x:rander.x,y:rander.y});
			}
		}
		protected function VLayout():void
		{
			this.points=[];
			for(var i:int=0;i<randers.length;i++)
			{
				var render:DisplayObject=randers[i] as DisplayObject;
				render.x=marginLeft;					
				var preHeight:Number=0;
				var prey:Number=0;
				var usedVerticalGap:Number=.0;
				if(i>0)
				{
					preHeight=randers[i-1].height;
					prey=randers[i-1].y;
					usedVerticalGap=verticalGap;
				}
				render.y=marginTop+preHeight+prey+usedVerticalGap;
				switch(horizonAlign)
				{
					case "center":
						render.x=(this.maxRanderWidth-render.width)/2;
						break;
					case "left":
						break;
					case "right":
						render.x=this.maxRanderWidth-render.width;
						break;
				}
				points.push({x:render.x,y:render.y});
			}
		}
		
		protected function get vpoints():Array
		{
			this.points=[];
			var p:Object={};
			for(var i:int=0;i<randers.length;i++)
			{
				var render:DisplayObject=randers[i] as DisplayObject;
				p.x=marginLeft;					
				var preHeight:Number=0;
				var prey:Number=0;
				var usedVerticalGap:Number=.0;
				if(i>0)
				{
					preHeight=randers[i-1].height;
					prey=points[i-1].y;
					usedVerticalGap=verticalGap;
				}
				p.y=marginTop+preHeight+prey+usedVerticalGap;
				switch(horizonAlign)
				{
					case "center":
						p.x=(this.maxRanderWidth-render.width)/2;
						break;
					case "left":
						break;
					case "right":
						p.x=this.maxRanderWidth-render.width;
						break;
				}
				points.push({x:p.x,y:p.y});
			}
			return points;
		}
		protected function get maxRanderWidth():Number
		{
			var width:Number=0;
			for each(var r:DisplayObject in visibleRanders)
			{
				if(r.width>width)
					width=r.width;
			}
			if(this.width>width)
				width=this.width;
			return width;
		}
		
//		public function dataingRander():void
//		{
//			var startIndex:int=getPageSize()*pageIndex;
//			var endIndex:int=getPageSize()*pageIndex+getPageSize();
//			if(this.listType==this.listTypes[0])
//				endIndex=pageSize*pageIndex+pageSize;
//			var pageData:Array=[];
//			if(endIndex>data.length)endIndex=data.length;
//			
//			for(var i:int=startIndex;i<endIndex;i++)
//			{
//				
//				pageData.push(_data[i]);
//			}
//			endIndex=getPageSize();
//			if(this.listType==this.listTypes[0])
//				endIndex=pageSize;
//			if(endIndex>pageData.length)endIndex=pageData.length;
//			for(i=0;i<endIndex;i++)
//			{
//				var rander:RenderBase=randers[i] as RenderBase;
//				rander.data=pageData[i];
//			}
//		}
		
//		/**
//		 *目前值是用于List中 
//		 **/
		protected function addRenderChild(render:RenderBase):RenderBase
		{
			this.showAbleSpace.addChild(render);
			return render;
		}
		
		private function removeRenderChild(render:RenderBase):void
		{
			showAbleSpace.removeChild(render);
		}
		
		public function removeAllRenderChild():void
		{
			removeTargetAllChild(showAbleSpace);
		}
		
		public function destroy():void
		{
			for each(var r:Object in randers)
			{
				if(r is RenderBase)
				{
					r.destroy();
				}
			}
			this.removeAllRenderChild();
		}
		
		public function set data(d:Object):void
		{	
			this._data=d;
			destroy();
			this.pageIndex=0;
			this.createRender();
			this.invalidate();
		}
		
		public function get data():Object
		{
			return this._data;
		}
		
		protected function onGroupClick(event:EventBase):void
		{
			
		}
		
		protected function onGroupOver(evt:EventBase):void
		{
			
		}
	}	
}