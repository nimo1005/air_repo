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
import mx.utils.Delegate;

import jp.cellfusion.commands.Command;
import jp.cellfusion.commands.ICommand;
import jp.cellfusion.commands.events.CommandEvent;
/**
 * @author Makoto
 */
class jp.cellfusion.commands.SerialCommand extends Command implements ICommand
{	
	private var _commands:Array;
	private var _currentIndex:Number;
	private var _commandProgressDelegate:Function;
	private var _commandCompleteDelegate:Function;

	/**
	 * 登録した複数のコマンドを一つずつ順番に実行します。
	 * <pre>
	 * // SerialCommand を作成後、add で Command を追加する
	 * var sq:SerialCommand = new SerialCommand();
	 * sq.add(new Command(null, trace, ["hoge"]));
	 * sq.add(new TimerCommand(null, trace, ["1秒後に実行"], 1000, 1));
	 * sq.add(new Command(null, trace, ["1秒後"]));
	 * 
	 * // 実行
	 * sq.execute();
	 * 
	 * // 作成時に Command を追加する
	 * var sq:SerialCommand = new SerialCommand(
	 * 	new TraceCommand("hoge"),
	 * 	new TimerCommand(null, trace, ["1秒後に実行"], 1000, 1),
	 * 	[new TraceCommand("同時に"), new TraceCommand("実行（といっても微妙に誤差は生じる）")]
	 * );
	 * 
	 * // 実行
	 * sq.execute();
	 * </pre>
	 * @param ... Command クラス
	 */
	public function SerialCommand()
	{
		_commandProgressDelegate = Delegate.create(this, _commandProgressHandler);
		_commandCompleteDelegate = Delegate.create(this, _commandCompleteHandler);
		
		_commands = new Array();
		_currentIndex = 0;
		
		switch (arguments.length) {
			case 0:
				break;
			case 1:
				if (arguments[0] instanceof Array) {
					var arr:Array = arguments[0];
					for (var i:Number = 0;i < arr.length; i++) add(arr[i]);
				} else {
					add(arguments[0]);
				}
				break;
			default:
				for (var i:Number = 0;i < arguments.length; i++) add(arguments[i]);
		}
	}

	/**
	 * コマンドを追加する
	 * @param	cmd 追加するコマンド
	 */
	public function add(cmd:Object):Void
	{
		var idx:Number = getItemIndex(_commands, cmd);
		if (idx == -1) _commands.push(cmd);
		else throw new Error("同じ command が見つかりました。");
	}

	/**
	 * コマンドを削除する
	 * @param	cmd 削除するコマンド
	 */
	public function remove(cmd:Command):Void 
	{
		var idx:Number = getItemIndex(_commands, cmd);
		if (idx != -1) _commands.splice(idx, 1);
		else throw new Error("commandが見つかりませんでした。");
	}

	/**
	 * 実行する
	 */
	public function execute():Void 
	{
		if (_commands.length > 0) {
			_currentIndex = 0;
			
			dispatchEvent(new CommandEvent(CommandEvent.COMMAND_START, this));
			
			_executeNext();
		} else {
			throw new Error("commandが登録されていません。");
		}
	}

	/**
	 * 中断する
	 */
	public function abort():Void 
	{
		var command = _commands[_currentIndex - 1];
		command.abort();
	}

	/**
	 * 再開する
	 */
	public function resume():Void 
	{
		var command = _commands[_currentIndex];
		if (command.resume != undefined) command.resume();
		else _executeNext();
	}

	/**
	 * 
	 */
	public function clone():ICommand 
	{
		var temp:SerialCommand = new SerialCommand();
		
		var i:Number = 0;
		var cmd:ICommand;
		while (cmd = _commands[i++]) {
			temp.add(cmd.clone());
		}
		
		return new temp
	}

	public function toString():String
	{
		return "[object SerialCommand]";
	}

	/**
	 * 破棄する
	 */
	public function destroy():Void 
	{
		abort();
		for (var idx:String in _commands) {
			_commands[idx].destroy();
		}
		_commands = new Array();
		_currentIndex = 0;
	}

	/**
	 * 次のコマンドを実行する
	 */
	private function _executeNext():Void
	{
		var command:ICommand = _commands[_currentIndex++];
		if (command) {
			command.addEventListener(CommandEvent.COMMAND_PROGRESS, _commandProgressDelegate);
			command.addEventListener(CommandEvent.COMMAND_COMPLETE, _commandCompleteDelegate);
			command.execute();
		} else {			dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
		}
	}
	
	/**
	 * コマンドを実行したときに呼び出される
	 */
	private function _commandProgressHandler(e:CommandEvent):Void
	{
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_PROGRESS, this));
	}
	
	/**
	 * コマンドを実行し終わると呼び出される
	 */
	private function _commandCompleteHandler(e:CommandEvent):Void
	{
		var command:ICommand = e.target;
		command.removeEventListener(CommandEvent.COMMAND_PROGRESS, _commandProgressDelegate);
		command.removeEventListener(CommandEvent.COMMAND_COMPLETE, _commandCompleteDelegate);
		
		_executeNext();
	}
}