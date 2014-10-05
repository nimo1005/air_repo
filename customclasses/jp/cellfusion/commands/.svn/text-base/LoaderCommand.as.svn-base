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
 * @author Makoto Matsutake
 */
class jp.cellfusion.commands.LoaderCommand extends Command implements ICommand 
{
	private var _mcl:MovieClipLoader;
	private var _url:String;
	private var _path:Object;
	
	private var _loaded:Number;	private var _total:Number;

	public function get loaded():Number { return _loaded; }
	public function get total():Number { return _total; }
	
	/**
	 * 読み込み処理を行うコマンド
	 * <pre>
	 * var cmd:LoaderCommand = new LoaderCommand("example.swf", main);
	 * cmd.execute();
	 * 
	 * // プログレスバーを表示する場合には addEventListener を使って COMMAND_PROGRESS イベントを監視します
	 * var cmd:LoaderCommand = new LoaderCommand("example.swf", main);
	 * 
	 * // AS2 では任意の関数に委譲するには Delegate.create を使って指定します
	 * _progressDelegate = Delegate.create(this, progressHandler);
	 * 
	 * // 先ほど作成した _progressDelegate を追加
	 * cmd.addEventListener(CommandEvent.COMMAND_PROGRESS, _progressDelegate);
	 * 
	 * cmd.execute();
	 * 
	 * // progressHandler
	 * function progressHandler(e:CommandEvent):Void {
	 *   var cmd:LoaderCommand = LoaderCommand(e.target);
	 *   
	 *   var percent:Number = cmd.loaded / cmd.total;
	 *   trace("load progress:"+(percent*100)+"%");
	 * }
	 * </pre>
	 * @param	url 読み込むURL
	 * @param	path 読み込み先
	 */
	public function LoaderCommand(url:String, path:Object) 
	{
		super();
		
		if (url == "" || url == null) {
			throw new Error("urlが空です。");
		} else {
			this._url = url;
		}
		
		if (path == "" || path == null) {
			throw new Error("pathが空です。");
		} else {
			this._path = path;
		}
		
		_mcl = new MovieClipLoader();
		_mcl.addListener(this);
	}

	/**
	 * 実行
	 */
	public function execute():Void 
	{
		_mcl.loadClip(_url, _path);
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

	/**
	 * クローン
	 */
	public function clone():ICommand 
	{
		return new LoaderCommand(_url, _path);
	}

	public function toString():String
	{
		return "[object LoaderCommand]";
	}

	private function onLoadStart(target:MovieClip):Void 
	{
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_START, this));
	}

	private function onLoadProgress(target:MovieClip, loaded:Number, total:Number):Void 
	{
		_loaded = loaded;
		_total = total;
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_PROGRESS, this));
	}

	private function onLoadComplete(target:MovieClip):Void 
	{
		
	}

	private function onLoadInit(target:MovieClip):Void 
	{
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
	}

	private function onLoadError():Void 
	{
		trace("error");
	}
}