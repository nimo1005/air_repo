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
class jp.cellfusion.commands.ASyncCommand extends Command implements ICommand 
{
	private var _url:String;
	private var _sendLV:LoadVars;
	private var _receiveLV:LoadVars;
	private var _method:String;
	private var _params:Object;
	
	public function result():LoadVars { return _receiveLV; }

	/**
	 * 
	 */
	function ASyncCommand(url:String, params:Object, method:String) 
	{
		_url = url;
		_params = params;
		_method = method == null ? "POST" : method;
		
		_sendLV = new LoadVars();
		_receiveLV = new LoadVars();
		
		_receiveLV.onLoad = Delegate.create(this, _loadHandler);
	}

	public function execute():Void
	{
		// パラメーター設定
		for (var idx:String in _params) {
			_sendLV[idx] = _params[idx];
		}
		
		_sendLV.sendAndLoad(_url, _receiveLV, _method);
		
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_START, this));
	}

	/**
	 * 中止
	 */
	public function abort():Void 
	{
	}

	/**
	 * 再会
	 */
	public function resume():Void 
	{
	}

	public function clone():ICommand
	{
		return new ASyncCommand(_url, _params, _method);
	}

	public function toString():String
	{
		return "[object ASyncCommand]";
	}

	private function _loadHandler(success:Boolean):Void
	{
		if (success) {
			dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
		}
		else {
			new Error("変数がロードできませんでした。");
		}
	}
}