package
{
//	import com.aopui.
	import client.command.InitSceneCommand;
	import client.mainui.BasicMainUIMediator;
	import client.mainui.MainUIMediator;
	import client.model.Model;	
	import com.aopui.Marshal;
	import com.aopui.admiral.BootAdmiral;
	import com.aopui.admiral.CursorAdmiral;
	import com.aopui.admiral.FontAdmiral;
	import com.aopui.admiral.MessageAdmiral;
	import com.aopui.command.AllPowerfulCommand;
	import com.aopui.effect.page.ListPageEffect;
	import com.aopui.event.pluginEvent.PluginNumPanelEvent;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.model.GlobalModel;
	import com.aopui.sdk.module.Plugin;
	import com.aopui.sdk.task.RookieTask;
	import com.aopui.ui.AreaField;
	import com.aopui.ui.ButtonBar;
	import com.aopui.ui.DynamicImg;
	import com.aopui.ui.Field;
	import com.aopui.ui.GameScene;
	import com.aopui.ui.HBox;
	import com.aopui.ui.Label;
	import com.aopui.ui.List;
	import com.aopui.ui.Panel;
	import com.aopui.ui.TileList;
	import com.aopui.ui.ToggleButtonBar;
	import com.aopui.ui.ToggleList;
	import com.aopui.ui.VBox;
	import com.aopui.ui.Window;
	
	import flash.display.Sprite;
	import flash.system.Security;
	
	import mx.core.BitmapAsset;
	import mx.core.ByteArrayAsset;
	import mx.core.FontAsset;
	import mx.core.SpriteAsset;
	import mx.resources.IResourceManager;
	
	[Frame(factoryClass="com.aopui.sdk.preloader.Preloader")]
	[SWF(width="800", height="800",backgroundColor="#000000", frameRate="60")]
	public class aopuiWithRealeaseExample extends BootAdmiral 
	{
		Plugin;
		RookieTask;
		Marshal;
		Panel;
		VBox;
		HBox;
		Label;
		ToggleButtonBar;
		DynamicImg;
		Field;
		AreaField;
		Window;
		TileList;
		List;
		SpriteAsset;
		ByteArrayAsset
		BitmapAsset;
		CursorAdmiral;
		ButtonBar;
		InitSceneCommand;		
		BasicMainUIMediator;
		MessageAdmiral;
		AllPowerfulMessage;
		AllPowerfulCommand;
		IResourceManager;
		FontAsset;
		GameScene;
		GlobalModel;
		Model;
		ToggleList;
		ListPageEffect;
		PluginNumPanelEvent;
		MainUIMediator;
		RookieTask;
		public function aopuiWithRealeaseExample()
		{
			GlobalModel.assetspre="com.aopui.assets";
			GlobalModel.non_server=true;
			//			GlobalModel.defaultBgAlpha=.5;
			var gf1:Object={color:0x505050,blur:2,strength:2,alpha:1}
			var gf3:Object={color:0x505050,blur:1,strength:1,alpha:.5}
			var gf2:Object={color:0x30083A,blur:2,strength:2,alpha:1}
			FontAdmiral.addFont("font1",{embed:false,font:"微软雅黑",color:0xffffff,size:16,bold:true,gf:gf2});
			FontAdmiral.addFont("font2",{embed:false,font:"微软雅黑",color:0xffffff,size:14,bold:true,gf:gf2});
		}
	}
}