/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 18, 2010
* WUSHIHUAN
*/
package com.aopui.ui
{
	import client.model.Model;
	
	import com.aopui.admiral.FontAdmiral;
	import com.aopui.admiral.LayoutAdmiral;
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.core.ContentLayer;
	import com.aopui.core.DefaultSkin;
	import com.aopui.core.inside;
	import com.aopui.effect.page.IPageEffect;
	import com.aopui.event.EventBase;
	import com.aopui.event.LifeEvent;
	import com.aopui.model.GlobalModel;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import spark.components.supportClasses.TextBase;

	
	
	public class BasicUI extends Sprite
	{
		
		public var needOverEffect:Boolean=true;
		protected var bgLayer:Sprite=new Sprite();
		public var contentLayer:Sprite=new ContentLayer();
		protected var scopeArea:Sprite=new DefaultSkin();
		protected var _skinClass:Class;
		protected var _bgInstance:Sprite;
		use namespace inside;
		private var _left:Number=-1;
		private var _right:Number=-1;
		private var _top:Number=-1;
		private var _bottom:Number=-1;
		private var _globalAlign:String;
		private var _input:Boolean;
		private var _eventListener:String;
		private var _horizonAlign:String="left";
		private var _verticalAlign:String="top";
		protected var _renderClass:Class;
		private var _pageSize:int=1;
		public var state:String="";
		public var gameuiType:String="";
		public static var _model:Model;
		
		public var cancalRect:Boolean=false;//在布局运算时候 以设置的高和宽为准 不以实际的高宽

		public var bgColor:int=-1;
		public static var _dispather:Function;
		private var _direction:String;
		
		public var parentui:BasicUI;
		
		/*
		 *值为true 表示此元件不被addChild 
		 **/
		public var noParent:Boolean=false;
		
		/**
		 *是否与显示内容同步宽高
		 **/
		public var SYNCSIZE:Boolean=true;
		public function BasicUI()
		{
			defaultAddChild(scopeArea);
			scopeArea.width=.000001;
			scopeArea.height=.000001;
			defaultAddChild(bgLayer);
			defaultAddChild(contentLayer);
			this.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		[Inspectable(enumeration="top","center","bottom")]
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		/**
		 * 目前仅仅用于DragAbleContainer
		 * 忽略minContentLeft 和 minContentRight 限制
		 * */
		public var ignoreContentLR:Boolean=false;
		
		/**
		 * 目前仅仅用于DragAbleContainer
		 * 拖动的内容可以拖动到距离容器最左边的距离
		 * */
		public var minContentLeft:Number=0;
		
		/**
		 * 目前仅仅用于DragAbleContainer
		 * 拖动的内容可以拖动到距离容器最右边的距离
		 * */
		public var minContentRight:Number=0;
		

		public function set verticalAlign(value:String):void
		{
			_verticalAlign = value;
		}
		
		protected var _offsetx:Number=0;
		public function get offsetx():Number
		{
			return _offsetx;
		}
		public function set offsetx(value:Number):void
		{
			_offsetx=value;
		}
		protected var _offsety:Number=0;
		public function get offsety():Number
		{
			return _offsety;
		}
		public function set offsety(value:Number):void
		{
			_offsety=value;
		}
		
		override public function set scaleX(value:Number):void
		{
			this._width*=value;
			super.scaleX=value;
			_scaleX=value;
		}
		
		override public function get scaleX():Number
		{
			return _scaleX;
		}
		
		private var _scaleX:Number=1;
		private var _scaleY:Number=1;
		override public function set scaleY(value:Number):void
		{
			this._height*=value;
			super.scaleY=value;
			_scaleY=value;
		}
		
		override public function get scaleY():Number
		{
			return _scaleY;
		}

		
		[Inspectable(enumeration="left","center","right")]
		public function get horizonAlign():String
		{
			return _horizonAlign;
		}

		public function set horizonAlign(value:String):void
		{
			_horizonAlign = value;
		}

		public function get eventListener():String
		{
			return _eventListener;
		}

		public function set eventListener(value:String):void
		{
			_eventListener = value;
		}

		
		
		public function set renderClass(cls:Class):void
		{
			_renderClass=cls;
		}
		
		public function get renderClass():Class
		{
			return _renderClass;
		}
		
		[Inspectable(enumeration="vertical","horizon")]
		public function get direction():String
		{
			return _direction;
		}
		
		public function set direction(value:String):void
		{
			_direction = value;
		}

		
		public function get input():Boolean
		{
			return _input;
		}
		
		/**
		 * 是否可以输入字符
		 * */
		public function set input(value:Boolean):void
		{
			_input = value;
		}		
		
		/**
		 *used in TxtBase
		 * 图标
		 **/
		public function set icon(value:*):void
		{
			
		}
		public function get icon():*
		{
			return null;
		}
		
		/**
		 *used in Listbase 
		 *垂直间隙
		 **/
		public function set verticalGap(value:Number):void
		{
			
		}
		
		public function get verticalGap():Number
		{
			return 0;
		}
		
		/**
		 *used in Listbase
		 *水平间隙
		 **/
		public function set horizonGap(value:Number):void
		{
			
		}
		public function get horizonGap():Number
		{
			return 0;
		}
		
		/**
		 *used in Txtbase,ListBase
		 * 字体					
		 * align(left,center,justify,right);	
		 * gf{color:0xFFFFFF,blur:2,strength,alpha:1}//发光滤镜
		 * dsf{distance:2,angle:90,color:0,alpha:1,blurX:4,blurY:4,strength:1,quality:1,inner:false,knockout:false,hideObject:false}//投影滤镜
		 * {是否使用嵌入字体,字体,字号,颜色,粗体,斜体,下划线,URL,target,对齐方式,左边距,右边距,缩进,行距}
		 * {embed,font,size,color,bold,italic,underline,url,target,align,leftMargin,rightMargin,indent,leading}
		 * target是显示超链接的目标窗口
		 */
		protected var _font:Object
		public function set font(ft:Object):void
		{
			_font=ft;
		}
		
		public function get font():Object
		{
			return _font;
		}
		
	
		
		
		/**
		 * used in TxtBase;
		 * 是否根据字的大小 确定背景的大小
		 **/
		public function set autoSize(value:Boolean):void
		{
			
		}
		
		public function get autoSize():Boolean
		{
			return false;
		}
		
		public function set autoWidth(b:Boolean):void
		{
			
		}
		public function get autoWidth():Boolean
		{
			return false;
		}
		
		public function set autoHeight(value:Boolean):void
		{
			
		}
		
		public function get autoHeight():Boolean
		{
			return false;
		}
		
		/**
		 *经验条类
		 * 素材需要跟skinClass匹配好(一样的尺寸)
		 **/
		public function set barSkinClass(cls:Class):void
		{
			
		}
		
		/**
		 * used in BaseDynamicImg;
		 * 所要加载的动态资源 最后显示的高
		 **/
		public function set imgHeight(value:Number):void
		{
		}
		
		public function get imgHeight():Number
		{
			return 0;
		}
		
		/**
		 * used in BaseDynamicImg;
		 * 所要加载的动态资源 最后显示的宽
		 **/
		public function set imgWidth(value:Number):void
		{
		}
		
		public function get imgWidth():Number
		{
			return 0;
		}
		
		protected var _marginTop:Number=0;
		protected var _marginLeft:Number=0;
		public function get marginTop():Number
		{
			return _marginTop;
		}
		
		/**
		 * used in ListBase,TxtBase;
		 * 组件的显示内容与注册点 0,0的垂直距离
		 **/
		public function set marginTop(value:Number):void
		{
			this._marginTop=value;
		}
		
		public function get marginLeft():Number
		{
			return _marginLeft;
		}
		
		/**
		 * used in ListBase,TxtBase;
		 * 组件的显示内容与注册点 0,0的水平距离
		 **/
		public function set marginLeft(value:Number):void
		{
			this._marginLeft=value;
		}
		
		protected var _marginRight:Number;
		public function set marginRight(value:Number):void
		{
			_marginRight=value;
		}
		
	
		public function get marginRight():Number
		{
			return _marginRight;
		}
		
		
		protected var _marginBottom:Number;
		public function set marginBottom(value:Number):void
		{
			_marginBottom=value;
		}
		
		public function get marginBottom():Number
		{
			return _marginBottom;
		}
		
		public function stateChange(state:String):void
		{
			
		}
		
		
		
		protected var _iconTop:Number;
		
		public function get iconTop():Number
		{
			return _iconTop;
		}
		
		/**
		 * used in TxtBase;
		 * 图标与注册点 0,0的垂直距离
		 **/
		public function set iconTop(value:Number):void
		{
			_iconTop=value;
		}
		
		
		protected var _iconLeft:Number;
		public function get iconLeft():Number
		{
			return _iconLeft;
		}
		
		/**
		 * used in TxtBase;
		 * 图标与注册点 0,0的水平距离
		 **/
		public function set iconLeft(value:Number):void
		{
			_iconLeft=value;
		}
		
		
		public function set iconHeight(value:Number):void
		{
			_iconHeight=value;
		}
		
		public function set iconWidth(value:Number):void
		{
			_iconWidth=value;
		}
		
		private var _iconHeight:Number;
		private var _iconWidth:Number;
		public function get iconWidth():Number
		{
			return _iconWidth;
		}
		
		public function get iconHeight():Number
		{
			return _iconHeight;
		}
		
		public function get bg():Sprite
		{
			return _bgInstance;
		}
		public function get dispatcher():Function
		{
			return _dispather;
		}
		public function get model():Model
		{
			return _model;
		}

		public function set model(value:Model):void
		{
			_model = value;
		}

		[Inspectable(enumeration="NE","NW","C","ES","WS","N","S","E","W")]
		public function get globalAlign():String
		{
			return _globalAlign;
		}
		
		
		public function set globalAlign(value:String):void
		{
			_globalAlign = value;
		}
		
		
		
		public function set textGlobalAlign(value:String):void
		{
			
		}
		
		public function get textGlobalAlign():String
		{
			return "";
		}
		

		public function get left():Number
		{
			return _left;
		}

		public function set left(value:Number):void
		{
			_left = value;
		}

		public function get right():Number
		{
			return _right;
		}

		public function set right(value:Number):void
		{
			_right = value;
		}

		public function get top():Number
		{
			return _top;
		}

		public function set top(value:Number):void
		{
			_top = value;
		}

		public function get bottom():Number
		{
			return _bottom;
		}

		public function set bottom(value:Number):void
		{
			_bottom = value;
		}

		override public function addChild(child:DisplayObject):DisplayObject
		{
			if(!child)return null;
			contentLayer.addChild(child);
			return child;
		}
		
		override public function get numChildren():int
		{
			return contentLayer.numChildren;
		}
		
		override public function getChildAt(index:int):DisplayObject
		{
			return contentLayer.getChildAt(index);
		}
		
		public function defaultGetChildAt(index:int):DisplayObject
		{
			return super.getChildAt(index);
		}
		
		inside function onAddToStage(e:Event):void
		{
			init();
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			this.stage.addEventListener(Event.RESIZE,resize);
		}
		
		protected function init():void
		{
			invalidate();
		}		
		
		public function defaultAddChild(child:DisplayObject):DisplayObject
		{
			return super.addChild(child);
		}
		public function defaultAddChildAt(child:DisplayObject,index:int):DisplayObject
		{
			return super.addChildAt(child,index);
		}
		
		public function defaultRemoveChild(child:DisplayObject):DisplayObject
		{
			return super.removeChild(child);
		}
		
		public function resize(e:Event):void
		{
			invalidate();
		}		
		
		public function defaultContains(child:DisplayObject):Boolean
		{
			return super.contains(child);
		}
		
		public function set skinClass(cls:Object):void
		{
			if(!cls)return;
			_skinClass=cls as Class;
			if(_bgInstance)
				bgLayer.removeChild(_bgInstance);
			_bgInstance=new cls();
//			removeTargetAllChild(bgLayer);
			bgLayer.addChildAt(_bgInstance,0);
			var rect:Rectangle=getBounds(_bgInstance);
			_bgInstance.x=-rect.left;
			_bgInstance.y=-rect.top;
			bgGoStop(1);
			_bgInstance.mouseEnabled=false;
			_bgInstance.mouseChildren=false;
			
		}
		
		public function invalidate():void
		{
			if(this.hasEventListener(Event.ENTER_FRAME))
				return;
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		
		/**现在这个布局机制还从在问题
		*嵌套几层ui就会执行几次layout方法;
		 * 
		*/
		//TODO 得想一个方法避免这个
		private function onInvalidate(e:Event):void
		{
		  this.removeEventListener(Event.ENTER_FRAME,onInvalidate);
		  if(!this.parentui)
		  {
		  layout();
		  _createComp();
		  }
		  else
		  {
			  _createComp();
		  }
		}
		public var autoDestroyImg:Boolean=false;
		private var isComp:Boolean=false;
		private function _createComp():void
		{
			if(!isComp)
				createComp();			
		}
		
		public function createComp():void
		{
			this.dispatchEvent(EventBase.createEvent(LifeEvent.CREATE_COMP));
		}
		
		
		public function get skinClass():Object
		{			
			return _skinClass;
		}
		
		protected function removeTargetAllChild(target:Sprite):void
		{
			if(!target)return;
			while(target.numChildren)
			{
				target.removeChildAt(0);
			}
		}
		
		public function removeAllChild():void
		{
			removeTargetAllChild(contentLayer);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			if(contentLayer.contains(child))
				return contentLayer.removeChild(child);
			return null;
		}
		
		public function layout():void
		{
//			if(SYNCSIZE)
//			{
//				var r:Rectangle=this.getBounds(this);
//				this.width=r.right;				
//				this.height=r.bottom;
//				if(_sizeChanged)
//					_sizeChanged=false;				
				//不能从这里去同步加入了新的元素后的大小 要在子类 去设置width 或者 height的时候就会自动的去设置scopeArea的大小了去同步  scopeArea的大小
//			}
			
			layoutSelfSize();
			layoutSize();
			layoutPosition();			//布局子容器的位置时   需要父容器确定大小
										//在没有设置父容器大小 又需要先布局子原件 大小 和子元件位置
			layoutSelfSize();
			dragColor();
		}
		protected function layoutSelfSize():void
		{
			
		}
		
		protected function layoutSize():void
		{
			LayoutAdmiral.layoutSize(this); 
			if(_heightChanged){
				if(_bgInstance)
					_bgInstance.height=this._height;
			}
			else
			{
				if(_bgInstance)
					this.height=_bgInstance.height;
			}
			
			if(_widthChanged)
			{
				if(_bgInstance)
					_bgInstance.width=this._width;
			}
			else
			{
				if(_bgInstance)
					this.width=_bgInstance.width;
			}
			
			if(_bgInstance)
			{
				var rect:Rectangle=getBounds(_bgInstance);
				_bgInstance.x=-rect.left;
				_bgInstance.y=-rect.top;
			}
		}
		
		
		protected function layoutPosition():void
		{
			LayoutAdmiral.layoutPosition(this);
		}
		
		protected function updateParentSize():void
		{
			if(this.parentui)
			{
				if(!parentui.widthChanged)
				{
					
				}
			}
		}
		
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			if(super.hasEventListener(type))super.removeEventListener(type,listener,useCapture);
		}
		
		protected function bgGoStop(i:int):void
		{
			if(_bgInstance is MovieClip)
			{
//				if(MovieClip(_bgInstance).currentFrame==i)return;
				try{MovieClip(_bgInstance).gotoAndStop(i);}catch(e:Object){
					trace("资源不符合规则");
				}
			}
		}
		
//		override public function set scaleX(value:Number):void
//		{
//			super.scaleX=value;
//		}
//		
//		override public function set scaleY(value:Number):void
//		{
//			super.scaleY=value;
//		}
		
		private var _width:Number;
		private var _height:Number;
		private var _sizeChanged:Boolean=false;
		private var _widthChanged:int=0;
		private var _heightChanged:int=0;
		
		override public function set width(value:Number):void
		{
			if(value==_width)
				return;
			_sizeChanged=true;
			_width=value;
			this.scopeArea.width=_width;
			if(_bgInstance)
			{
				_bgInstance.width=value;
			}
			_widthChanged+=1;
		}
		public function set $width(value:Number):void
		{
			super.width=value;
		}
		
		public function set $height(value:Number):void
		{
			super.height=value;
		}
		
		public function get $width():Number
		{
			return super.width;
		}
		
		public function get $height():Number
		{
			return super.height;
		}
		
		public function setValue(id:String,prop:String,value:Object):void
		{
			var o:Object=$[id];
			if(!o)
				return;
			if(o[prop]==value)
				return;
			o[prop]=value;
		}
		
		override public function get width():Number
		{
			if(_bgInstance)return _bgInstance.width;
			if(_width)
				return _width*scaleX;
			else
				return super.width;
		}
		
		override public function get height():Number
		{
			if(_bgInstance)return _bgInstance.height;
			if(_height)
				return _height*scaleY;
			else
				return super.height;
		}
		
		override public function set height(value:Number):void
		{
			if(_height==value)
				return;
			_height=value;
			_sizeChanged=true;
			this.scopeArea.height=_height;
			if(_bgInstance)
			{
				_bgInstance.height=value;
			}
			_heightChanged+=1;
		}
		
		public function scaleByWidth(width:Number,target:DisplayObject):Number
		{
			var scaleValue:Number;
			if(target)
			{
				scaleValue=width/target.width;
			}
			else
			{
				scaleValue=width/this.width;
			}
			return scaleValue;
		}
		
		public function scaleByHeight(height:Number,target:DisplayObject):Number
		{
			var scaleValue:Number;
			if(target)
			{
				scaleValue=height/target.height;
				target.scaleX=scaleValue;
				target.scaleY=scaleValue;
			}
			else
			{
				scaleValue=height/this.height;
				this.scaleX=scaleValue;
				this.scaleY=scaleValue;
			}
			return scaleValue;
		}
		
		public function getUI(uiname:String):Class
		{
			return ResourceAdmiral.getUI(uiname) as Class;
		}
		
		public function set xml(x:XML):void
		{
			var c:XMLList=x.children();
			appPro(x,null);				
		}	
		private var _components:Object={};
		
		public var $:Object=_components;
		public function showInCenter():void
		{
			LayoutAdmiral.showInCenter(this);
		}
		
		public function dragColor():void
		{
			if(this.bgColor!=-1)
			{
				this.graphics.clear();
				this.graphics.beginFill(this.bgColor);
				this.graphics.drawRect(0,0,this.width,this.height);
				this.graphics.endFill();
			}
			else
			{
				this.graphics.clear();
			}
		}
		
		private function appPro(xmlData:XML,parent:Object):void
		{
			var instance:Object;
			var cls:Class;
			var clsStr:String=xmlData.name()+"";
			if(parent)
			{
				if(xmlData.@path+""!="")
					cls=getUI(xmlData.@path+"."+clsStr);
				else
					cls=getUI("com.aopui.ui."+clsStr);
				instance=new cls();
			}
			else
			{
				instance=this;
			}
	
			for each(var pro:Object in xmlData.attributes())
			{
				var stypeName:String=pro.name().localName;
				var special:Boolean=false;
				var tmp:String=xmlData.attribute("id");
				var value:Object=xmlData.attribute(stypeName)+"";
				
				switch(value)
				{
					case "true":
						value=true;
						break;
					case "false":
						value=false;
						break;
				}
				
				switch(stypeName)
				{
					case "id":
						_components[value]=instance;
						special=true;
						break;
					case "buttonSkinClass":
						instance.buttonSkinClass=getUI(value+"");
						special=true;
						break;
					case "renderClass":
						var tmpCls:Class
						try{
							tmpCls=getUI("com.aopui.ui."+value);
						}catch(o:*){}
						if(!tmpCls)
							tmpCls=getUI(value+"");
						instance.renderClass=tmpCls;
						special=true;
						break;
					case "eventListener":
						var eventObj:Object=xmlData.attribute(stypeName)[0];
						eventListener=eventObj+"";
						eventObj=eventObj.split(",");
//						var listeners:Array;
//						listeners=eventObj.slice(1);
						var eventListenerStep:int=1;
						for each(var s:String in eventObj){
							if((eventListenerStep/2)==int(eventListenerStep/2))
								instance.addEventListener(eventObj[eventListenerStep-2],Object(this)[s]);							
							eventListenerStep++;
						}
						special=true;
						break;
					case "skinClass":
						instance.skinClass=getUI(value+"");
						special=true;
						break;
					case "barSkinClass":
						instance.barSkinClass=getUI(value+"");
						special=true;
						break;
//					case "noParent":
//						noParent=value;
//						special=true;
//						break;
					case "pageEffect":
						var clss:Class=getUI(value+"");
						var pe:IPageEffect=new clss();
						instance.pageEffect=pe;
						special=true;
						break;
					case "path":
						special=true;
						break;
					case "mouseChildren":
						var mouseChildren:String=xmlData.attribute(stypeName)+"";
						if(mouseChildren=="false")
							instance.mouseChildren=false;
						else
							instance.mouseChildren=true;
						special=true;
						break;
					case "cursor":
						if(xmlData.attribute(stypeName)+""!="non")
							instance[stypeName]=getUI(xmlData.attribute(stypeName)+"");
						else
							instance[stypeName]="non";
						special=true;
						break;
					case "icon":
						instance.icon=getUI(xmlData.@icon+"");
						special=true;
						break;
					case "font":
						instance[stypeName]=FontAdmiral.getFont(value+"");
						special=true;
						break;
					case "W":
						instance["width"]=value;
						special=true;
						break;
					case "H":
						instance["height"]=value;
						special=true;
						break;
					case "WH":
					case "HW":
						instance["width"]=value.split(",")[0];
						instance["height"]=value.split(",")[1];
						special=true;
						break;
					case "XY":
					case "YX":
						instance["x"]=value.split(",")[0];
						instance["y"]=value.split(",")[1];
						special=true;
						break;
					case "trbl":
						instance["top"]=value.split(",")[0];
						instance["right"]=value.split(",")[1];
						instance["bottom"]=value.split(",")[2];
						instance["left"]=value.split(",")[3];
						special=true;
						break;
					default:
						break;
				}
				if(!special)
				{
					instance[stypeName]=value;
				}
			}
			
			
//			var noParent:String=xmlData.@noParent
			if(noParent!="true" && parent)
			{
				parent.addChild(instance as DisplayObject);
			}
			
			
			if(xmlData.children().length()>0)
			{
				for each(var xmlData:XML in xmlData.children())
				{
					appPro(xmlData,instance);
				}
			}
		}

		public function get pageSize():int
		{
			return _pageSize;
		}

		public function set pageSize(value:int):void
		{
			_pageSize = value;
		}

		public function get heightChanged():int
		{
			return _heightChanged;
		}

		public function set heightChanged(value:int):void
		{
			_heightChanged = value;
		}

		public function get widthChanged():int
		{
			return _widthChanged;
		}

		public function set widthChanged(value:int):void
		{
			_widthChanged = value;
		}

		
	}
}