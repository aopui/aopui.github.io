/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 19, 2010
* WUSHIHUAN
*/
package com.aopui.ui.txt
{
	import com.aopui.ui.list.RenderBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.TextElement;
	

	public class TxtBase extends RenderBase
	{

		public var _textField:TextField=new TextField();
		private var _textFormat:TextFormat=new TextFormat(null,14,null,true,null,null,null,null,"left");
		private var _textFormatObj:Object
		protected var _textString:String="";
		private var _autoSize:Boolean=false;
		private var _autoWidth:Boolean=false;
		private var _autoHeight:Boolean=false;
		
		
//		protected var barInstance:Sprite;
		public function TxtBase()
		{
			super();
			this.marginLeft=2;
			this.marginRight=2;
			this.marginTop=2;
			this.marginBottom=2;			
			input=false;
		}
		public function set text(txt:String):void
		{	
			_textString=txt;
			_textField.defaultTextFormat=_textFormat;
			_textField.embedFonts=_embedfont;
			if(gf)
				_textField.filters=[gf];
			_textField.text=txt;
			this.invalidate();
		}
		public function get text():String
		{
			return _textString;
		}
		override public function set width(value:Number):void
		{
			super.width=value;
//			this._textField.width=value-marginLeft*2;
		}
		override public function set height(value:Number):void
		{
			super.height=value;
//			this._textField.height=value-marginTop*2;
		}
		public function set fontSize(value:Object):void
		{
			_textFormat.size=value;
			_textField.defaultTextFormat=_textFormat;
			invalidate();
		}
		public function set color(value:Object):void
		{
			_textFormat.color=value;
			_textField.defaultTextFormat=_textFormat;
		}
		
		
		private function initTxtField():void
		{
			this.removeAllChild();
			_textField=new TextField();
			_textField.type=TextFieldType.DYNAMIC;
			_textField.mouseEnabled=false;	
			addChild(_textField as DisplayObject);
			text="";
			_textField.defaultTextFormat=_textFormat;	
		}
		private function initTxtInput():void
		{
//			this.removeAllChild();
//			_textField=new TextField();
			_textField.type=TextFieldType.INPUT;
//			addChild(_textField as DisplayObject);
//			text="";			
			_textField.defaultTextFormat=_textFormat;
			_textField.text=this._textString;
			_textField.addEventListener(TextEvent.TEXT_INPUT,onInput);
		}
		private function onInput(e:TextEvent):void
		{
			_textField.defaultTextFormat=_textFormat;
			this._textString=_textField.text;
			text=_textString;
		}
		
		override public function set input(value:Boolean):void
		{
			super.input=value;
			if(value)
			{				
				initTxtInput();
			}
			else
			{
				initTxtField();
			}
		}		
		
		override public function get iconTop():Number
		{
			return _iconTop;
		}

		override public function set iconTop(value:Number):void
		{
			_iconTop = value;
		}

		override public function get iconLeft():Number
		{
			return _iconLeft;
		}

		override public function set iconLeft(value:Number):void
		{
			_iconLeft = value;
		}

		/**
		 * margin些列属性是配合autoSize,autoWidth,autoHeight 系列属性使用的
		 * 如果没有设置autoSize些列属性那么margin些列属性无用处
		*/
		
		override public function set marginTop(value:Number):void
		{
			_marginTop=value;
			this.invalidate();
		}
		override public function get marginTop():Number
		{
			return _marginTop;
		}
		
		override public function set marginLeft(value:Number):void
		{
			super.marginLeft=value;
		}
		override public function get marginLeft():Number
		{
			return super.marginLeft;
		}
		
		
		private var _textGlobalAlign:String="C";
		override public function set textGlobalAlign(value:String):void
		{
				_textGlobalAlign=value;
		}
		
		override public function get textGlobalAlign():String
		{
			return _textGlobalAlign;
		}
		
		
		override public function get autoSize():Boolean
		{
		
			return _autoSize;
		}

		override public function set autoSize(value:Boolean):void
		{
			this.autoWidth=true;
			this.autoHeight=true;
			_autoSize = value;
		}		
	
		override public function get  autoWidth():Boolean
		{
			return _autoWidth;
		}
		
		override public function set autoWidth(value:Boolean):void
		{
			_autoWidth=value;
		}
		
		override public function get autoHeight():Boolean
		{
			return _autoHeight;
		}
		
		override public function set autoHeight(value:Boolean):void
		{
			_autoHeight=value;
		}

		

		
		private var gf:Object;
		private var dsf:Object;
		override public function set font(tf:Object):void
		{	_textFormatObj=tf; 
			_textField.filters=[];
			if(!tf.hasOwnProperty("font"))
				return;
			for(var s:String in tf)
			{
				if(s=="embed")
				{
					this.EmbedFont=tf[s];
				}
				else if(s=="gf")
				{
					if(_textField.filters.indexOf(tf[s])<0)
						this._textField.filters=this._textField.filters.concat(tf[s]);
					gf=tf[s];
				}
				else if(s=="dsf")
				{
					if(_textField.filters.indexOf(tf[s])<0)
						this._textField.filters=this._textField.filters.concat(tf[s]);
					dsf=tf[s];
				}
				else
					_textFormat[s]=tf[s];
			}
			this.text=_textString;
		}
		
		override public function get font():Object
		{
			return _textFormatObj;
		}
		private var _embedfont:Boolean=false;
		public function set EmbedFont(value:Boolean):void
		{
			if(_embedfont==value)
					return;
			_embedfont=value;
		}
		public function get EmbedFont():Boolean
		{
			return _embedfont;
		}
		

		override public function layout():void
		{
			super.layout();
			if(this._textField.text=="")
				return;
			_textField.width=_textField.textWidth+4;
			_textField.height=_textField.textHeight+4;
			
			if(_autoWidth)
			{
				this.width=_textField.width+this.marginLeft+this.marginRight;
				_textField.x=marginLeft;
			}
			if(_autoHeight)
			{
				this.height=_textField.height+this.marginTop+marginBottom;
				_textField.y=marginTop;
			}

			//目前的高与宽都确定了
			
			if(_textGlobalAlign)
			{
				var alignData:Array=textGlobalAlign.split(",")
				switch(alignData[0])
				{
					case "S":
						textFieldx=this.width/2-_textField.width/2;
						textFieldy=this.height-_textField.height;							
						break;
					case "N":
						textFieldy=0;
						textFieldx=this.width/2-_textField.width/2;
						break;
					case "E":
						textFieldx=this.width-_textField.width;
						textFieldy=this.height/2-_textField.height/2;
						break;
					case "W":
						textFieldx=0;
						textFieldy=this.height/2-_textField.height/2;
						break;
					case "EN":
					case "NE":
						textFieldy=0;
						textFieldx=this.width-_textField.width;
						break;
					case "WN":
					case "NW":
						textFieldy=0;
						textFieldx=0;
						break;
					case "ES":
					case "SE":
						textFieldx=this.width-_textField.width;
						textFieldy=this.height-_textField.height;
						break;
					case "WS":
					case "SW":
						textFieldx=0;
						textFieldy=this.height-_textField.height;
						break;
					case "C":
						textFieldx=this.width/2-_textField.width/2;
						textFieldy=this.height/2-_textField.height/2;
						break;
					case "VC":
					case "CV":
						textFieldy=this.height/2-_textField.height/2;
						break;
					case "HC":
					case "CH":
						textFieldx=this.width/2-_textField.width/2;
						break;
					default:
						break;
				}
				
				if(textFieldx<0)
					textFieldx=0;
				if(textFieldy<0)
					textFieldy=0;
				if(alignData.length>1)
				{
					for(var i:int=1;i<alignData.length;i++)
					{
						tuning(alignData[i]);
					}
				}					
			}
		
		
		}
		
		private function tuning(param:String):void
		{
			param=param.toLocaleLowerCase();
			var align:String=param.substr(0,1);
			var value:String=param.substr(1);			
			this["textField"+align]+=Number(value);
		}
		
		protected function  set textFieldx(value:Number):void
		{
			if(!autoWidth)
				_textField.x=value;
		}
		
		protected function get textFieldx():Number
		{
			return _textField.x;
		}
		
		
		protected function set textFieldy(value:Number):void
		{
			if(!autoHeight)
				_textField.y=value;
		}
		
		protected function get textFieldy():Number
		{
			return _textField.y;
		}
		
		public function  set htmlText(txt:String):void
		{
			if(_textField.text==txt)return;
//			_textField.defaultTextFormat=_textFormat;
			_textField.embedFonts=_embedfont;
			_textField.htmlText=txt;
			_textField.setTextFormat(_textFormat);
//			_textField.width=_textField.textWidth+4;
//			_textField.height=_textField.textHeight+4;
			this.invalidate();
		}
		
		override public function set data(d:Object):void
		{
			super.data=d;
			try
			{
				if(d.txt){
					text=d.txt;
				}
				if(d.icon)
				{
					this.icon=d.icon;
				}
			} 
			catch(error:Error) 
			{

			}
		
		}
		
		

		
	}
}