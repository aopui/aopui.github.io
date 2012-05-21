package client.mainui.model
{

	public class BuddyListModel
	{
		[MessageDispatcher]
		public var dispatch:Function;
		
		private var _buddyInfos:Array=[];
		
		public function BuddyListModel()
		{
			trace("buddyList Model Constructed!");
		}
		
		[Init]
		public function init():void
		{
			//TODO dispatch( new GetBuddyListMessage());
			trace("BuddyListModel");
		}
		
		public function get buddyInfos():Array
		{
			return _buddyInfos;
		}
	}
}