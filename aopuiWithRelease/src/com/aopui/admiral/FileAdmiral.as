package com.aopui.admiral
{
	import com.adobe.images.PNGEncoder;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;

	public class FileAdmiral
	{
		public function FileAdmiral()
		{
			
		}
		
		public static function saveJPG(fileName:String,bitmapData:BitmapData,quality:Number=75.0):void
		{
			var jpgByte:ByteArray;
			var jpegE:JPEGEncoder=new JPEGEncoder(quality);
			jpgByte=jpegE.encode(bitmapData);			
			var file:File;//=File.documentsDirectory.resolvePath(fileName);
			file=new File(fileName);
			var fileStream:FileStream=new FileStream();			
			fileStream.open(file,FileMode.WRITE);			
			fileStream.writeBytes(jpgByte);
			fileStream.close();
		}
		
		public static function savePNG(fileName:String,bitmapData:BitmapData):void
		{
			var pngByte:ByteArray;
			pngByte=PNGEncoder.encode(bitmapData);
			var file:File;//=File.documentsDirectory.resolvePath(fileName);
			file=new File(fileName);
			var fileStream:FileStream=new FileStream();			
			fileStream.open(file,FileMode.WRITE);			
			fileStream.writeBytes(pngByte);
			fileStream.close();		
		}
		
		public static function saveFile(fileName:String, data:ByteArray):void
		{
			var file:File=File.documentsDirectory.resolvePath(fileName);
//			file=new File(fileName);
			var fileStream:FileStream=new FileStream();			
			fileStream.open(file,FileMode.WRITE);			
			fileStream.writeBytes(data);
			fileStream.close();		
		}
		
		public static function  fileisExist(path:String):Boolean
		{
			var f:File=new File(path);
			if(f.exists)
				return true;
			return false;
		}
		
		public static function readString(path:String):String
		{
			var templeteString:String;
			var tempfile:File=new File(path);
			var fileStream:FileStream=new FileStream();
			fileStream.open(tempfile,FileMode.READ);
			templeteString=fileStream.readUTFBytes(fileStream.bytesAvailable) as String;
			fileStream.close();
			return templeteString;
		}
		
		public static function writeString(path:String,content:String):void
		{
			var templeteString:String;
			var tempfile:File=new File(path);
			var fileStream:FileStream=new FileStream();
			fileStream.open(tempfile,FileMode.WRITE);
			fileStream.writeUTFBytes(content);
			fileStream.close();		
		}
	
		public static function getFileByType(dir:File,extension:String):Array
		{
			var s:Array=dir.getDirectoryListing();
			var files:Array=[];
			for(var i:int=0;i<s.length;i++)
			{
				if(!(s[i].isDirectory)&& s[i].extension.toLocaleUpperCase()==extension.toLocaleUpperCase())
					files.push(s[i]);
				else if(s[i].isDirectory)
				{
					files=files.concat(getFileByType(s[i] as File,extension));
				}
			}
			return files;
		}
		
		//获得某个路径下得子文件夹
		public static function getDirsOfDir(dir:File):Array
		{
			if(!dir.exists)
				return [];
			var s:Array=dir.getDirectoryListing();
			var files:Array=[];
			for(var i:int=0;i<s.length;i++)
			{
				if(s[i].isDirectory)
					files.push(s[i]);
			}
			return files;
		}
	}
}