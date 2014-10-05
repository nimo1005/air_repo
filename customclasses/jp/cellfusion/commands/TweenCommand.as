import mx.transitions.OnEnterFrameBeacon;
import mx.transitions.Tween;
import mx.utils.Delegate;

import jp.cellfusion.commands.Command;
import jp.cellfusion.commands.ICommand;
import jp.cellfusion.commands.events.CommandEvent;
/**
 * @author Makoto Matsutake
 */
class jp.cellfusion.commands.TweenCommand extends Command implements ICommand 
{
	private var target:Object, prop:Array, func:Function, begin:Array, finish:Array, duration:Number, useSeconds:Boolean;
	private var _tweens:Array;
	
	/**
	 * 標準搭載の Tween クラスを使って動きをつけます
	 */
	public function TweenCommand(target:Object, prop:Array, func:Function, begin:Array, finish:Array, duration:Number, useSeconds:Boolean)
	{
		OnEnterFrameBeacon.init();
		this.target = target;
		this.prop = prop;
		this.func = func;
		this.begin = begin;
		this.finish = finish;
		this.duration = duration;
		this.useSeconds = useSeconds;
		
		_tweens = new Array();
	}

	public function execute():Void
	{
		for (var i:Number = 0;i < prop.length; i++) {
			var tween:Tween = new Tween(target, prop[i], func, begin[i], finish[i], duration, useSeconds);
			_tweens.push(tween);
		}
		
		tween.onMotionFinished = Delegate.create(this, motionFinishedHandler);
		tween.onMotionStarted = Delegate.create(this, motionStartedHandler);
		tween.start();
	}

	/**
	 * 中止
	 */
	public function abort():Void 
	{
		for (var i:Number = 0;i < _tweens.length; i++) {
			_tweens[i].stop();
		}
	}

	/**
	 * 再会
	 */
	public function resume():Void 
	{
		for (var i:Number = 0;i < _tweens.length; i++) {
			_tweens[i].resume();
		}
	}

	public function clone():ICommand
	{
		return new TweenCommand(target, prop, func, begin, finish, duration, useSeconds);
	}

	public function toString():String
	{
		return "[object TweenCommand]";
	}

	private function motionStartedHandler():Void
	{
		MovieClip.addListener(this);
		//		trace("motionStarted");
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_START, this));
	}

	private function motionFinishedHandler():Void
	{
		MovieClip.removeListener(this);
		//		trace("motionFinished");
		//		trace(target);
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
	}

	private function onEnterFrame():Void
	{
		//		var e:Object = {type:COMMAND_PROGRESS, target:target};
		//		
		//		for (var i : String in prop) {
		//			e[prop[i]] = target[prop[i]];
		//		}
		//		
		//		dispatchEvent(e);
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_PROGRESS, this));
	}
}