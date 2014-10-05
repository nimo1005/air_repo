import jp.cellfusion.commands.Command;
import jp.cellfusion.commands.ICommand;
/** * @author Mk-10 a.k.a. cellfusion */class jp.cellfusion.commands.TraceCommand extends Command implements ICommand 
{	public function TraceCommand(message:String)
	{		super(null, trace, [message]);	}
	
	public function clone():ICommand
	{		return new TraceCommand(_args[0]);
	}
}