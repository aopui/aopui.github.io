package client.model
{
	import com.aopui.model.GlobalModel;

	
	
	[Bindable]
	public class Model extends GlobalModel
	{	
		
		public function Model()
		{
			this.formatXML(XML(_dna.xml.PATH),"path");
			
		}
		
		
		
		
	}
}