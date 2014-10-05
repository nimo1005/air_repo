/*
 * Copyright(c) 2007 Mk-10 cellfusion.jp
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */
import jp.cellfusion.commands.Command;
import jp.cellfusion.commands.ICommand;
import jp.cellfusion.commands.events.CommandEvent;
/**
 * @author Makoto
 */
class jp.cellfusion.commands.TimerCommand extends Command implements ICommand 
{
	private var _delay:Number;

	public function get delay():Number 
	{ 
		return _delay; 
	}

	public function set delay(value:Number):Void 
	{ 
		_delay = value; 
	}

	private var _repeatCount:Number;

	public function get repeatCount():Number 
	{ 
		return _repeatCount; 
	}

	public function set repeatCount(value:Number):Void 
	{ 
		_repeatCount = value; 
	}

	private var _count:Number;

	public function get count():Number 
	{ 
		return _count; 
	}

	public function set count(value:Number):Void 
	{ 
		_count = value; 
	}

	private var _isResume:Boolean;

	public function get isResume():Boolean 
	{ 
		return _isResume; 
	}

	private var _isWorking:Boolean;

	public function get isWorking():Boolean 
	{ 
		return _isWorking; 
	}

	private var _intervalID:Number;
	private var _time:Number;
	private var _resumeDelay:Number;
	private var _startTime:Number;
	private var _resumeTime:Number;
	private var _pauseTime:Number;

	/**
	 * 指定した delay ごとに関数を実行します
	 * <pre>
	 * new tmrCmd:TimerCommand = new TimerCommand();
	 * </pre>
	 */
	public function TimerCommand(thisObj:Object, funcRef, args:Array, delay:Number, repeatCount:Number) 
	{
		super(thisObj, funcRef, args);
		
		if (repeatCount == undefined) repeatCount = 1;
		_delay = delay;
		_repeatCount = repeatCount;
		_isWorking = false;
		
		reset();
	}

	/**
	 * 
	 */
	public function execute():Void 
	{
		reset();
		
		_isWorking = true;
		_startTime = getTimer();
		
		_intervalID = _global.setInterval(this, "checkTime", delay);
	}

	/**
	 * 
	 */
	public function abort():Void 
	{
		if (_isWorking) {
			_global.clearInterval(_intervalID);
			_pauseTime = getTimer();
			_resumeDelay = _delay - (getTimer() - _time);
			
			_isWorking = false;
			_isResume = true;
		}
	}

	/**
	 * 
	 */
	public function resume():Void 
	{
		if (!_isWorking && _isResume) {
			_resumeTime += getTimer() - _pauseTime;
			_time = getTimer();
			
			_isWorking = true;
			_isResume = false;
			
			_intervalID = _global.setInterval(this, "checkTime", _delay);
		}
	}

	/**
	 * 
	 */
	public function stop()
	{
		if (_isWorking) {
			_isWorking = false;
			
			_global.clearInterval(_intervalID);
			complete();
		}
	}

	/**
	 * 
	 */
	public function reset() 
	{
		_global.clearInterval(_intervalID);
		_count = 0;
		_time = getTimer();
		_resumeDelay = Infinity;
		_isResume = false;
		_resumeTime = 0;
	}

	/**
	 * 
	 */
	public function clone():ICommand
	{
		return new TimerCommand(_thisObj, _funcRef, _args, _delay, _repeatCount);
	}

	public function toString():String
	{
		return "[object TimerCommand]";
	}

	/**
	 * 普通に実行していると微妙に遅れてくるので毎秒ごとに誤差を修正する
	 * 参考 : apeirophobia: 正確なタイマーを作る（できるだけ）
	 * URL : http://blog.img8.com/archives/2007/06/003093.html
	 */
	private function checkTime() 
	{
		_global.clearInterval(_intervalID);
		
		var nowTime:Number = getTimer();
		var fixTime:Number = -nowTime + _startTime + _delay * (++_count + 1) + _resumeTime;
		
		var dtime:Number = nowTime - _startTime - _resumeTime;
		progress();
		
		if (_repeatCount <= _count && _repeatCount != 0) {
			_isWorking = false;
			complete();
		}
		else _intervalID = _global.setInterval(this, "checkTime", fixTime);
	}

	private function progress():Void 
	{
		var func:Function = (typeof(_funcRef) == "string") ? _thisObj[_funcRef] : _funcRef;
		var rslt = func.apply(_thisObj, _args);
		
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_PROGRESS, this));
	}

	private function complete():Void
	{
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
	}
}