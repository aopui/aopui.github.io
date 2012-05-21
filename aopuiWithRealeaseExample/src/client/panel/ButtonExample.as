package client.panel
{
	import com.aopui.admiral.FontAdmiral;
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.ui.IconButton;
	import com.aopui.ui.Panel;
	
	public class ButtonExample extends Panel
	{
		public function ButtonExample()
		{
			IconButton;
			super();
			/**
			 *Button
			 *特性 
			 * 1.可以赋予皮肤
			 * 			1.1 皮肤制作规则
			 * 					
			 * 2.可以显示文字 并设置字体
			 * 		2.1 设置文本 text="文本"
			 * 		2.2 设置字体 font="注册过的字体名称";
			 * 3.自动布局 
			 * 			3.1 没有指定宽，高  
			 * 					3.1.1 skin的尺寸大于 文字的尺寸 那么按钮的大小就 是skin的大小
			 * 					3.1.2 skin的尺寸小于 文字的尺寸 按钮的 宽=文字宽+4；高=文字高+4
			 * 			3.2 指定了宽，高
			 * 					3.2.1 尺寸= 指定的宽 高 ，当文字大于指定的尺寸时候将显示部分文字
			 **/
			xml=<layout trbl="0,0,0,0" state="button">
					<VBox verticalGap="5" >
							<Label text="textGlobalAlign相关操作" skinClass="labelSkin" autoSize="true"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="S,Y-5" WH="300,80"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="N,Y5" WH="300,80"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="E,X-5" WH="300,80"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="W,X5" WH="300,80"/>
				
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="ES,Y-5,X-5" WH="300,80"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="EN,Y5,X-5" WH="300,80"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="WN,X5,Y5" WH="300,80"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="WS,X5,Y-5" WH="300,80"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" textGlobalAlign="C" WH="300,80"/>
					</VBox>
					<VBox x="310" id="b2" horizonAlign="center">
							
							<Label text="没有设置任何布局属性" skinClass="labelSkin" autoSize="true"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin"/>
				
				
							<Label text="autoSize=true" skinClass="labelSkin" autoSize="true"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoSize="true"/>
				
							<Label text="autoSize=true,设置了margin相关属性" skinClass="labelSkin" autoSize="true"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoSize="true" marginBottom="20"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoSize="true" marginTop="20"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoSize="true" marginLeft="20"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoSize="true" marginRight="20"/>
					
							<Label text="autoWidth=true" skinClass="labelSkin"  autoSize="true"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoWidth="true" marginRight="20"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoWidth="true" marginLeft="20"/>
								
							<Label text="autoHeight=true" skinClass="labelSkin"  autoSize="true"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoHeight="true"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoHeight="true" marginTop="20"/>
							<Button  text="进入游戏" font="font1" skinClass="buttonSkin" autoHeight="true" marginBottom="20"/>
					</VBox>
					<VBox globalAlign="NE" width="120">
							<Label text="iconButton" skinClass="labelSkin"  autoSize="true"/>
							<IconButton iconSkin="iconSkin" text="一个苹果"  font="font2" labelSkin="labelSkin" />
				
							<IconButton iconSkin="iconSkin" WH="100,50"  iconWH="26,30" text="一个苹果"  font="font2"  iconGlobalAlign="W" labelGlobalAlign="E,Y5"/>
				<!--
<IconButton  text="一个苹果"  font="font2" WH="190,30" iconWH="26,30" iconSkin="iconSkin"  iconGlobalAlign="W,X2" labelGlobalAlign="WS,X30"/>
				-->
					</VBox>
				</layout>
				
//				var iconButton:IconButton=new IconButton();
//				     iconButton.iconSkin="iconSkin";
//					 iconButton.text="一个苹果";
//					 iconButton.font=FontAdmiral.getFont("font2");
//					 $.b2.addChild(iconButton);
				
		}
	}
}