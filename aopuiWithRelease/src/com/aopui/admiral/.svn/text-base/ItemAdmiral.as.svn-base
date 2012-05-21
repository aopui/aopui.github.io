////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 23, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.admiral
{
	import com.aopui.model.Category;

	public class ItemAdmiral
	{
		/*			
		数据结构={categories
					sub:Catgory
					items:Item
				}
		*/
		public static var categories:Array=[];
		
		private static var _data:Object;
		public function ItemAdmiral()
		{
		}
		
		public function getItemById(id:Object):Object
		{
			return null;
		}
		
		public function getCategoryById(id:Object):Category
		{
			return null;
		}
		
		
		public static function setData(d:Object):void
		{
			_data=d;
			analysisDataColonel();
		}
		
		private static function analysisDataColonel ():void
		{
			//解析一级分类
			var c:Category;
			for(var s:String in _data)
			{
				if(s.indexOf("orderd")<0 && s.indexOf("common_food")<0)
				{
						c=new Category();
						c.id=s;
						c.name=s;
						categories.push(c);
				}
			}
			//解析二级分类
			s="";
			for each ( var cs:Category in categories)
			{
				s=cs.name;
				var usedLength:int=0;
				switch(s)
				{
					case "common_fish":
						for(var i:int=1;i<=3;i++)
						{
							c=new Category();
							c.parent=cs;
							c.id="deep_"+i;
							c.parent.categories.push(c);
						}
						//分析鱼
						for each(var fc:Category in cs.categories)
						{
							var deep:String=fc.id;
							var f:Object;
							usedLength=0;
							for each(var tmpf:String in _data["orderd_fish"])
							{
								f=_data[s][tmpf];
								if(deep==f.ocean_deep)
								{
									f.nameid=tmpf;
									f.itemType="fish";
									fc.items.push(f);
									if(fc.used)
									usedLength++;
								}
							}
							if(usedLength<1)
								fc.used=false;
						}
						break;
					case "decoration":
						for(var decType:String in _data["decoration"])
						{
							c=new Category();
							c.parent=cs;
							c.id=decType;
							c.parent.categories.push(c);
						}
						for each(var dc:Category in cs.categories)
						{
							if(dc.id=="fangzhiwu"){
								var d:Object;
								usedLength=0;
								for each(var tmpd:String in _data["orderd_decoration"])
								{
									d=_data[s]["fangzhiwu"][tmpd];	
									d.itemType="decoration";
									d.nameid=tmpd;
									dc.items.push(d);
									if(d.used)
									usedLength++;
								}
								if(usedLength<1)
									dc.used=false;
							}
							else
							{
								dc.used=false;
							}
						}
						
						break;
					case "items":
						for(var itemType:String in _data["items"])
						{
							c=new Category();
							c.parent=cs;
							
							c.id=itemType;
							c.parent.categories.push(c);					
						}
						for each(var ic:Category in cs.categories)
						{		
							usedLength=0;
							for (var tmpn:String in _data["items"][ic.id])
							{
								var tmpi:Object;
								tmpi=_data["items"][ic.id][tmpn];
								ic.items.push(tmpi);
								tmpi.itemType="items";
								tmpi.nameid=tmpn;
								if(tmpi.used)
									usedLength++;
							}
							if(usedLength<1)
								ic.used=false;
						}
						break;
					case "gift_bag":
						
						var gc:Category=new Category();
						gc.id="gift_bag";
						gc.parent=cs
						cs.categories.push(gc);
						for each(var gift:String in _data["orderd_bag"])
						{
							var gb:Object=_data["gift_bag"][gift];
							gb.itemType="gift_bag";
							gb.nameid=gift;
							gc.items.push(gb);
						}
						
						break;
					default:
						break;
				}
			}
			
			var tmpArray:Array=[getCate("common_fish"),getCate("decoration"),getCate("items"),getCate("gift_bag")];
			
			categories=tmpArray;
			
		}
		
		private static function getCate(s:String):Category
		{
			for each(var c:Category in categories)
			{
				if(c.id==s)
				{
					return c;
				}
			}
			return null;
		}
	
	}
}