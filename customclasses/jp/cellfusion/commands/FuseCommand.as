﻿import jp.cellfusion.commands.events.CommandEvent;

import com.mosesSupposes.fuse.Fuse;
import com.mosesSupposes.fuse.ZigoEngine;

import jp.cellfusion.commands.Command;
import jp.cellfusion.commands.ICommand;
/**
{	
	private var _fuse:Fuse;
	private var _params:Array;

	/**
	 * FuseKit を使って Tween します
	 */
	{
		ZigoEngine.register(Fuse);
		
		_params = arguments;
		_fuse = new Fuse();
		
		var i:Number = 0;
		var obj:Object;
		while (obj = arguments[i++]) {
			_fuse.push(obj);
		}
	
	public function execute():Void
	{
		_fuse.addEventListener("onComplete", this);
		_fuse.start();
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_START, this));
	
	public function clone():ICommand
	{
		var fuse:Fuse = new Fuse();
		
		var i:Number = 0;
		var obj:Object;
		while (obj = _params[i++]) {
			_fuse.push(obj);
		}
		
	}
	
	public function abort():Void
	{
	}
	
	public function resume():Void
	{
	
	private function onComplete():Void
	{
		dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
	}
}