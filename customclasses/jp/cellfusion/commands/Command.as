﻿/* * Copyright(c) 2007 Mk-10 cellfusion.jp *  * Licensed under the Apache License, Version 2.0 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at * * http://www.apache.org/licenses/LICENSE-2.0 * * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, * either express or implied. See the License for the specific language * governing permissions and limitations under the License. */import mx.events.EventDispatcher;
import jp.cellfusion.commands.ICommand;import jp.cellfusion.commands.events.CommandEvent;class jp.cellfusion.commands.Command implements ICommand{		private var _thisObj:Object;	private var _funcRef;	private var _args:Array;	private var _eventDispatcher:EventDispatcher;		/**	 * 関数を実行するコマンド	 * <pre>	 * // 通常はこんな風に使う	 * var cmd:Command = new Command(null, trace, ["hoge"]);	 * cmd.execute();	 * 	 * // 文字列でも関数を指定できる	 * var cmd:Command = new Command(null, "trace", ["fuga"]);	 * cmd.execute();	 * </pre>	 * @param thisObj 関数を実行するスコープ	 * @param funcRef 実行する関数	 */	public function Command(thisObj:Object, funcRef, args:Array) 	{		_eventDispatcher = new EventDispatcher();				_thisObj = thisObj;		_funcRef = funcRef;		_args = args;	}
	/**	 * 実行	 */	public function execute():Void 
	{		var func:Function		if (_thisObj == null) {			func = typeof(_funcRef) == "string" ? _global[_funcRef] : _funcRef;		} else {			func = typeof(_funcRef) == "string" ? _thisObj[_funcRef] : _funcRef;		}		func.apply(_thisObj, _args);				dispatchEvent(new CommandEvent(CommandEvent.COMMAND_PROGRESS, this));				dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));	}
	public function clone():ICommand 
	{		return new Command(_thisObj, _funcRef, _args);	}
	public function abort():Void 
	{	}
	public function resume():Void 
	{	}
	/**	 * 	 */	function toString() 
	{		return "[object Command]";	}
	/**	 * 初期化処理	 */	private function initialize():Void	{	}
	private function arrayContains(arr:Array, obj:Object):Boolean	{		var index = getItemIndex(arr, obj);		return (index >= 0);	}
	private function getItemIndex(arr:Array, obj:Object):Number	{		for (var i = 0;i < arr.length; i++) if (arr[i] === obj) return i; 		return -1;	}
	public function addEventListener(event:String, handler:Object):Void	{		_eventDispatcher.addEventListener(event, handler);	}
	public function removeEventListener(event:String, handler:Object):Void	{		_eventDispatcher.removeEventListener(event, handler);	}
	private function dispatchEvent(event:CommandEvent):Void	{		_eventDispatcher.dispatchEvent(event);	}}