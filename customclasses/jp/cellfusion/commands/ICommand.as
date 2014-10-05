import jp.cellfusion.commands.Command;
/** * @author cellfusion */interface jp.cellfusion.commands.ICommand 
{	/**	 * 	 */	public function execute():Void;		/**	 * 	 */	public function clone():ICommand;		/**	 * 中断する	 */	public function abort():Void;		/**	 * 再開する	 */	public function resume():Void;
	
	function addEventListener(event:String, handler:Object):Void;
	
	function removeEventListener(event:String, handler:Object):Void;}