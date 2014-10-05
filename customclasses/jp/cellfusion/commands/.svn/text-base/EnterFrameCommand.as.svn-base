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

import mx.transitions.OnEnterFrameBeacon

;import jp.cellfusion.commands.Command
;import jp.cellfusion.commands.ICommand
;import jp.cellfusion.commands.events.CommandEvent
;/**
 * @author Makoto Matsutake
 */
class jp.cellfusion.commands.EnterFrameCommand extends Command implements ICommand {
	private var _delay:Number;
	public function get delay():Number { return _delay; }
	
	private var _repeatCount:Number;
	public function get repeatCount():Number { return _repeatCount; }
	
	private var _currentDelay:Number;
	public function get currentDelay():Number { return _currentDelay; }
	
	private var _currentCount:Number;
	public function get currentCount():Number { return _currentCount; }
		/**
	 * 毎フレームごとに関数を実行するコマンド
	 */
	public function EnterFrameCommand(thisObj:Object, funcRef, args:Array, delay:Number, repeatCount:Number) 	{
		super(thisObj, funcRef, args);
		OnEnterFrameBeacon.init();
		
		_delay = delay;
		_repeatCount = repeatCount == undefined ? 1 : repeatCount;
		
		_currentDelay = 0;
		_currentCount = 0;
	}
	/**
	 * 実行
	 */
	public function execute():Void	{
		reset();
		MovieClip.addListener(this);
	}
	/**
	 * 中止
	 */
	public function abort():Void	{
		MovieClip.removeListener(this);
	}
	/**
	 * 再会
	 */
	public function resume():Void	{
		MovieClip.addListener(this);
	}
	/**
	 * リセット
	 */
	public function reset():Void	{
		_currentCount = 0;
		_currentDelay = 0;
	}
	/**
	 * クローン
	 */
	public function clone():ICommand 	{
		return new EnterFrameCommand(_thisObj, _funcRef, _args, _delay, _repeatCount);
	}
	public function toString():String
	{
		return "[object EnterFrameCommand]";
	}
	private function onEnterFrame():Void	{
		_currentDelay++;
		if (_currentDelay == _delay) {
			_currentDelay = 0;
			
			var func:Function
			if (_thisObj == null) {
				func = typeof(_funcRef) == "string" ? _global[_funcRef] : _funcRef;
			} else {
				func = typeof(_funcRef) == "string" ? _thisObj[_funcRef] : _funcRef;
			}
			func.apply(_thisObj, arguments);
			
			_currentCount++;
			
			// 繰り返し回数が 0 の場合は終了しない
			if (_currentCount == _repeatCount && _repeatCount != 0) {
				commandComplete();
			}
		}
	}
	private function commandComplete():Void	{
		MovieClip.removeListener(this);
		
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
	}
}