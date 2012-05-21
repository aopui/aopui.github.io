package com.aopui.admiral
{

	public class ArrayAdmiral
	{		
		public static function delOneItem(arr:Array,index:int):void
		{
			arr.splice(index,1);
		}
		
		public static function delItem(arr:Array,start:int,count:int):void
		{
			arr.splice(start,count);
		}
		
		public static function switchItem(arr:Array,index1:int,index2:int):void
		{
			var i1:Object=arr[index1];
			var i2:Object=arr[index2];
			arr[index1]=i2;
			arr[index2]=i1;
		}
		
		/**
		 *del all the type of "clsType"
		 **/
		public static function delItemByType(array:Array,clsType:Class):Array
		{
			for(var i:int=array.length-1;i>=0;i--)
			{
				if(array[i] is clsType)
				{
					delOneItem(array,i);
				}
			}
			return array;
		}
		
		public static function isIncludeType(array:Array,clsType:Class):Boolean
		{
			
			for(var i:int=array.length-1;i>=0;i--)
			{
				if(array[i] is clsType)
				{
					return true;
				}
			}
			return false;
		}
	}
}