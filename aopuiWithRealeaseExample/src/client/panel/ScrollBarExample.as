package client.panel
{
	import client.view.pageEffect.MobileScrollBarPageEffect;
	import client.view.pageEffect.ScollBarPageEffect;
	
	import com.aopui.ui.Panel;
	import com.aopui.ui.TextArea;
	
	public class ScrollBarExample extends Panel
	{
		public function ScrollBarExample()
		{
			MobileScrollBarPageEffect;
			TextArea;
			super();			
			xml=<layout trbl="0,0,0,0" pageEffect="client.view.pageEffect.MobileScrollBarPageEffect">
						
					<Panel WH="110,1210" bgColor="0xffffff">
						<VBox  x="5" y="5" WH="100,1200" verticalGap="1">
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>
							<Panel WH="100,100" bgColor="0xfff000"/>				
						</VBox>
					</Panel>
					<!--	
						<TextArea
									id="text1" 
									pageEffect="client.view.pageEffect.ScollBarPageEffect"
									font="font1"
									width="480" 
									height="480"									
						/>
				-->
			
					</layout>
//6222 0204 0902 6307 960
					return;
			$.text1.htmlText=				
				"<font color='#ffff00' size='18'>PRODUCTION CREW</font><br><br>"+
				"<font color='#ffffff'><textformat leading='7'>"+
				"Director............................................................................YIMENG BAI<br>"+
				"Producer..........................................................................RACHEL HAN XU<br>"+
				"Writer................................................................................LYN STEPHENSON<br>"+
				"1st Assistant Director...................................................MICHAEL IINUMA<br>"+
				"2nd Assistant Director.................................................JESSE LEE<br>"+
				"Director of Photography..............................................JEREMY ROYCE<br>"+
				"1st Assistant Cameraman..........................................MARCUS DEL NEGRO<br>"+
				"2nd Assistant Cameraman.........................................CHRISTOPHER PERALTA<br>"+
				"Gaffer................................................................................DEREK DEEMS<br>"+
				"Key Grip............................................................................WILL JOBE<br>"+
				"Best Boy...........................................................................MATT GRACE<br>"+
				"SWING...............................................................................WILL JOBE<br>"+
				"<font color='#000000'>............................................................................................</font>ISABELO PASCUAL<br>"+
				"Boom Operator...............................................................NEAL DOXSEE<br>"+
				"<font color='#000000'>............................................................................................</font>QI CAO<br>"+
				"<font color='#000000'>............................................................................................</font>JOHN NORDLINGER<br>"+
				"Production Designer.....................................................ELLEN DONNELLY<br>"+
				"Art Director......................................................................XIA MAGNUS<br>"+
				"1st Assistant Set Designer..........................................ALYSSA POLK<br>"+
				"2nd Assistant Set Designer.........................................JEAN-LUC UNGER<br>"+
				"Makeup Artist..................................................................AKIKO TANAHASHI<br>"+
				"Still Photographer..........................................................CHRISTOPHER PERALTA<br>"+
				"Casting Director.............................................................RACHEL HAN XU<br>"+
				"Continuity / Script supervisor......................................XINYI BAO<br>"+
				"Craft Services.................................................................RACHEL HAN XU<br>"+
				"Location support............................................................THE MAL'S"+
				
				"</textformat></font><br><br><br>"+
				
				
				
				
				"<font color='#ffff00' size='18'>POST PRODUCTION</font><br><br>"+
				"<font color='#ffffff'><textformat leading='7'>"+
				"Sound Designer<br>"+
				"Editor.................................................................................YIMENG BAI<br>"+
				"Color Corrector..............................................................JEREMY ROYCE<br>"+
				"Music Score....................................................................VIDJAY BEEREPOOT</textformat></font><br><br><br>"+
				
				
				"<font color='#ffff00' size='18'>WEBSITE</font><br><br>"+
				"<font color='#ffffff'><textformat leading='7'>"+
				"Creative Director...........................................................YIMENG BAI<br>"+
				"Digital Designer.............................................................LONG CHENG<br>"+
				"IT Director.......................................................................SHIHUAN WU<br>"+
				"AGENCY...........................................................................<a href='http://www.aopui.com'><U>AOPUI STUDIO</U></a></textformat></font><br><br><br>"+
				
				
				"<font color='#ffff00' size='18'>CAST</font><br><br>"+
				"<font color='#ffffff'><textformat leading='7'>"+
				"Alex...................................................................................LUCA RODRIGUES<br>"+
				"Brent................................................................................SHAUN CHIEPPO<br>"+
				"Catherine........................................................................EVITA M. CASTINE<br>"+
				"Dominic...........................................................................ERIN WILSON<br>"+
				"Ethan................................................................................ERIC RUBIN</textformat></font><br><br><br>"+
				
				
				"<font color='#ffff00' size='18'>SPECIAL THANKS TO</font><br><br>"+
				"<font color='#ffffff'><textformat leading='7'>"+
				"NANCY HECHINGER<br>"+
				"MARINA ZURKOW<br>"+
				"MARIANNE PETIT<br>"+
				"HUAWEI SUN<br>"+
				"WEISONG GAO</textformat></font>"
		}
		
		override public function layout():void
		{
			super.layout();
			pageEffect&&pageEffect.layout();
		}
		
	}
}