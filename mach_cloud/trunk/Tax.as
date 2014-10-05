package
{
	/**
	 * ...
	 * @author t
	 */
	public class Tax 
	{
		private static var _instance:Tax;
		private var _tax_obj:Object;
		
		public function Tax() 
		{
			// constructor code
		}
		
		public static function getInstance():Tax 
		{
			if(_instance == null) 
			{
				_instance = new Tax();
			}
			return _instance;
		}
				
		public function setTax(tax:Object):void
		{
			_tax_obj = tax;
		}
		
		public function getTax():Object
		{
			return _tax_obj;
		}

	}

}