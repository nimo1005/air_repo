import jp.cellfusion.commands.Command;/**
 * @author Makoto
 */
class jp.cellfusion.commands.events.CommandEvent {
	public static var COMMAND_START:String = "commandStart";	public static var COMMAND_PROGRESS:String = "commandProgress";
	public static var COMMAND_COMPLETE:String = "commandComplete";	public static var COMMAND_ERROR:String = "commandError";
	private var _type:String;	public function get type():String	{		return _type;	}		private var _target:Command;	public function get target():Command 	{ 		return _target;	}
	public function CommandEvent(type:String, target:Command)
	{
		_type = type;		_target = target;
	}
}