﻿import com.mosesSupposes.fuse.ZigoEngine;/*** Fuse Kit 2* Copyright (c) 2006 Moses Gunesch, MosesSupposes.com* * Distributed under MIT Open Source License, see Fuse-Kit-License.html (in fuse package directory)* Easing Equations (c) 2003 Robert Penner used by permission, see PennerEasing* Visit http://www.mosessupposes.com/Fuse* * @ignore** Pass this class to {@link com.mosesSupposes.fuse.ZigoEngine#register} or {@link com.mosesSupposes.fuse.ZigoEngine#simpleSetup} * to enable tween-shortcut functionality and 'easyfunc' callback parsing.* @usage* Example 1: You can use shortcut syntax without modifying prototypes or targets.* <pre>import com.mosesSupposes.fuse.*;* import mx.transitions.easing.Elastic;* ZigoEngine.register(Shortcuts);* * ZigoEngine.doShortcut(my_mc, 'brightOffsetTo', 100, 1, Elastic.easeOut);</pre>* <br>* Example 2: You can copy and remove shortcut methods to individual targets without modifying prototypes.* <pre>import com.mosesSupposes.fuse.*;* import mx.transitions.easing.Elastic;* ZigoEngine.register(Shortcuts);* * ZigoEngine.initialize(my_mc);* my_mc.brightOffsetTo(200, 1, Elastic.easeOut);* //later...* ZigoEngine.deinitialize(my_mc);</pre>* <br>* Example 3: Use simpleSetup instead of register to modify prototypes for classic lmc_tween style usage. Remember that any setup * command only needs to be called once at the beginning of your program.* <pre>import com.mosesSupposes.fuse.*;* ZigoEngine.simpleSetup(Shortcuts, PennerEasing);* * my_mc.brightOffsetTo(200, 1, 'easeOutElastic');* * // If you also pass FuseItem during simpleSetup,* // you can use Object Syntax with the tween shortcut:* my_mc.tween({ start_x:"-100", start_y:"-100", ease:"easeInOutBack", time:1.5 });* </pre>* <br>* Shortcut methods are variations on {@link com.mosesSupposes.fuse.ZigoEngine#doTween} syntax and return a formatted string indicating properties successfully tweened. * In each method listed below <code>target</code> refers to whatever MovieClip or TextField you wish to tween.* <br><br><br>* <h3>Shortcut Properties:</h3>* <br>* If you've extended prototypes with {@link com.mosesSupposes.fuse.ZigoEngine#simpleSetup}, you may use these the same as normal properties like <code>_x</code>:* <pre><b>my_mc._brightness</b> = 50;</pre>* <br>* <ul>* <li><b><code>_brightness</code></b> (See brightnessTo)</li>* <li><b><code>_brightOffset</code></b> (See brightOffsetTo)</li>* <li><b><code>_colorReset</code></b> (See colorResetTo)</li>* <li><b><code>_colorTransform</code></b> Accepts or returns a generic color-transform object with properties like ra, rb, etc. (See colorTransformTo)</li>* <li><b><code>_contrast</code></b> (See contrastTo)</li>* <li><b><code>_fade</code></b> A proxy for _alpha that sets _visible false for any value less than 50, typically used with 0 or 100 values.</li>* <li><b><code>_frame</code></b> Sets or retrieves the current frame of a MovieClip's timeline.</li>* <li><b><code>_invertColor</code></b> (See invertColorTo)</li>* <li><b><code>_scale</code></b> Sets _xscale and _yscale to the same value.</li>* <li><b><code>_size</code></b> Sets _width and _height to the same value.</li>* <li><b><code>_tint</code></b> Accepts 0x000000 or "#000000" formats. Returns a color-value number.</li>* <li><b><code>_tintPercent</code></b> Sets or retrieves the tint percentage of a target that has had its color altered previously.</li>* <li><b><code>_tintString</code></b> Like _tint, but returns a human-readable hex-string like "0xFF33FF" easily converted to a usable color value using <code>Number()</code>.</li>* </ul>* <br><br><br>* <h3>Property-Tweening Shortcut Methods:</h3> * <pre>target.<b>alphaTo</b> (alpha:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens <code>_alpha</code>. Supports relative (string) end-value.* <pre>target.<b>bezierTo</b> (x:Object, y:Object, controlX:Object, controlY:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Generates a simple curved path. Supports relative (string) values; use <code>"0"</code> for <code>x</code> or <code>y</code> to affect no change, use <code>null</code> for <code>controlX</code> or <code>controlY</code> to auto-center the control point.  In this way a curve can be generated with only two values, like this arc that hops up-then-down while sliding right: <code>my_mc.bezierTo("200","0",null,"-50");</code>* <pre>target.<b>fadeIn</b> (seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Automatically sets the target's <code>_visible</code> property to true, then tweens <code>_alpha</code> to 100.* <pre>target.<b>fadeOut</b> (seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens <code>_alpha</code> to 0 then automatically sets the target's <code>_visible</code> property to false.* <pre>target.<b>frameTo</b> (frame:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* MovieClip only: tweens the clip's timeline to the desired frame.* <pre>target.<b>rotateTo</b> (rotation:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens <code>_rotation</code>. Supports relative (string) end-value, such as this counter-clockwise rotation: <code>my_mc.rotateTo("-90");</code>* <pre>target.<b>scaleTo</b> (scale:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens <code>_xscale</code> and <code>_yscale</code> to the same value. Supports relative (string) end-value.* <pre>target.<b>sizeTo</b> (size:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens <code>_width</code> and <code>_height</code> to the same value. Supports relative (string) end-value.* <pre>target.<b>slideTo</b> (x:Object, y:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens <code>_x</code> and <code>_y</code>. Supports relative (string) values; use <code>"0"</code> or <code>null</code> to affect no change for either coordinate. <br>* <br>* <br>* <h3>Color-Tweening Shortcut Methods:</h3>* <pre>target.<b>brightnessTo</b> (brightness:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens brightness between -100 (black), 0 (normal) and 100 (white)* <pre>target.<b>brightOffsetTo</b> (brightOffset:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens a burn effect between -100 (black), 0 (normal) and 100 (white)* <pre>target.<b>colorTo</b> (rgb:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens a clip's color. Accepts 0x000000 or "#000000" formats.* <pre>target.<b>colorResetTo</b> (percent:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Use 100 to fully restore a target's colors to normal. (For most color effects a positive number less than 100 can be passed to affect a partial change.)<br>* <pre>target.<b>colorTransformTo</b> (ra:Object, rb:Object, ga:Object, gb:Object, ba:Object, bb:Object, aa:Object, ab:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens specific properties of a color-transform. Supports relative (string) values or pass <code>null</code> to affect no change on that property. The "a" values are percentages while "b" values are -255 to 255 offsets.* <pre>target.<b>contrastTo</b> (level:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens photo contrast between 0 (gray), 100 (normal), or higher (200 for extreme contrast, higher to posterize image). Supports relative (string) end-value.* <pre>target.<b>invertColorTo</b> (percent:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Photo-negative effect from 0-100. Supports relative (string) end-value.* <pre>target.<b>tintTo</b> (rgb:Object, percent:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Similar to <code>colorTo</code>, with a tint-percentage value in the second parameter. Supports relative (string) end-value for percentage.* <pre>target.<b>tintPercentTo</b> (percent:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* Tweens the tint percentage of a target that has had its color altered previously. Supports relative (string) end-value. <br>* <br>* <br>* <h3>Tween Control Methods:</h3>* (see similar methods in {@link com.mosesSupposes.fuse.ZigoEngine} for additional info.) * <pre>target.<b>tween</b> (props:Object, endVals:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String</pre>* <pre>target.<b>removeTween</b> (props:Object):Void</pre>* <pre>target.<b>removeAllTweens </b>():Void</pre>* <pre>target.<b>isTweening </b>(prop:String):Boolean</pre>* <pre>target.<b>getTweens</b>():Number</pre>* <pre>target.<b>lockTween</b>():Void</pre>* <pre>target.<b>unlockTween</b>():Void</pre>* <pre>target.<b>isTweenLocked</b>():Boolean</pre>* <pre>target.<b>isTweenPaused</b>(prop:String):Boolean</pre>* <pre>target.<b>pauseTween </b>(props:Object):Void</pre>* <pre>target.<b>resumeTween </b>(props:Object):Void</pre>* <pre>target.<b>pauseAllTweens </b>():Void</pre>* <pre>target.<b>resumeAllTweens </b>():Void</pre>* <pre>target.<b>ffTween </b>(props:Object):Void</pre>* <pre>target.<b>rewTween </b>(props:Object,suppressStartEvents:Boolean):Void</pre>* <pre>target.<b>rewAndPauseTween </b>(props:Object,suppressStartEvents:Boolean):Void</pre>* <pre>target.<b>skipTweenTo </b>(second:Number,props:Object):Void</pre>* <br>* <br>* <h3>Legacy Methods:</h3>* (retained for compatibility with earlier versions)* <pre>target.<b>stopTween </b>(props:Object):Void</pre>* <pre>target.<b>stopAllTweens </b>():Void</pre>* <pre>target.<b>unpauseTween </b>(props:Object):Void</pre>* <pre>target.<b>unpauseAllTweens </b>():Void</pre>* <br>* <br>* <h3>FuseFMP tweening shortcuts</h3>* For use with FuseFMP and {@link com.mosesSupposes.fuse.ZigoEngine#simpleSetup} (prototype extension) only.* <br><br>* The format follows the convention short-filtername+"_"+filter property+"To".* <pre>* // example:* import com.mosesSupposes.fuse.*;* ZigoEngine.simpleSetup(Shortcuts, PennerEasing, FuseFMP);* <b>my_mc.DropShadow_angleTo</b>("45", 2, "easeOutElastic");* * Bevel_angleTo* Bevel_blurTo* Bevel_blurXTo* Bevel_blurYTo* Bevel_distanceTo* Bevel_highlightAlphaTo* Bevel_shadowAlphaTo* Bevel_strengthTo* Blur_blurTo* Blur_blurXTo* Blur_blurYTo* Convolution_alphaTo* Convolution_colorTo* DisplacementMap_alphaTo* DisplacementMap_colorTo* DropShadow_alphaTo* DropShadow_angleTo* DropShadow_blurTo* DropShadow_blurXTo* DropShadow_blurYTo* DropShadow_colorTo* DropShadow_distanceTo* DropShadow_strengthTo* Glow_alphaTo* Glow_blurTo* Glow_blurXTo* Glow_blurYTo* Glow_colorTo* Glow_strengthTo* GradientBevel_angleTo* GradientBevel_blurTo* GradientBevel_blurXTo* GradientBevel_blurYTo* GradientBevel_distanceTo* GradientBevel_strengthTo* GradientGlow_angleTo* GradientGlow_blurTo* GradientGlow_blurXTo* GradientGlow_blurYTo* GradientGlow_distanceTo* GradientGlow_strengthTo</pre>* <br><br><br>* <h3>FuseFMP Shortcut Properties</h3><br>* (see similar methods in {@link com.mosesSupposes.fuse.FuseFMP} for additional info.)* <pre></pre>* <br><br><br>* <h3>FuseFMP Shortcut Properties: Blur_blurX, etc.</h3>* {@link com.mosesSupposes.fuse.FuseFMP} property formatting follows the convention: short-filtername+"_"+filter property.* <br>Example with {@link com.mosesSupposes.fuse.ZigoEngine#register} (see {@link com.mosesSupposes.fuse.FuseFMP} for more info):* <pre>import com.mosesSupposes.fuse.*;* import mx.transitions.easing.Elastic;* ZigoEngine.register(Shortcuts, FuseFMP);* ZigoEngine.doTween(my_mc, <b>"DropShadow_angle"</b>, "45", 2, Elastic.easeOut);* </pre>* If {@link com.mosesSupposes.fuse.ZigoEngine#simpleSetup} is used you may also get/set properties directly on a target:* <pre><b>my_mc.DropShadow_angle</b> = 105;</pre>* (Note that this is an optional feature of {@link com.mosesSupposes.fuse.FuseFMP} that may be used without ZigoEngine.)* <br>* <pre>Bevel_type* Bevel_blurY* Bevel_blurX* Bevel_blur* Bevel_knockout* Bevel_strength* Bevel_quality* Bevel_shadowAlpha* Bevel_shadowColor* Bevel_highlightAlpha* Bevel_highlightColor* Bevel_angle* Bevel_distance* Blur_quality* Blur_blurY* Blur_blurX* Blur_blur* ColorMatrix_matrix* Convolution_alpha* Convolution_color* Convolution_clamp* Convolution_preserveAlpha* Convolution_bias* Convolution_divisor* Convolution_matrix* Convolution_matrixY* Convolution_matrixX* DisplacementMap_alpha* DisplacementMap_color* DisplacementMap_mode* DisplacementMap_scaleY* DisplacementMap_scaleX* DisplacementMap_componentY* DisplacementMap_componentX* DisplacementMap_mapPoint* DisplacementMap_mapBitmap* DropShadow_hideObject* DropShadow_strength* DropShadow_blurY* DropShadow_blurX* DropShadow_blur* DropShadow_knockout* DropShadow_inner* DropShadow_quality* DropShadow_alpha* DropShadow_color* DropShadow_angle* DropShadow_distance* Glow_strength* Glow_blurY* Glow_blurX* Glow_blur* Glow_knockout* Glow_inner* Glow_quality* Glow_alpha* Glow_color* GradientBevel_type* GradientBevel_knockout* GradientBevel_strength* GradientBevel_quality* GradientBevel_blurY* GradientBevel_blurX* GradientBevel_blur* GradientBevel_ratios* GradientBevel_alphas* GradientBevel_colors* GradientBevel_angle* GradientBevel_distance* GradientGlow_type* GradientGlow_knockout* GradientGlow_strength* GradientGlow_quality* GradientGlow_blurY* GradientGlow_blurX* GradientGlow_blur* GradientGlow_ratios* GradientGlow_alphas* GradientGlow_colors* GradientGlow_angle* GradientGlow_distance* </pre>* <br>* <i>Methods and properties of this class are excluded here - see class file for further documentation.</i>* @author	Moses Gunesch / MosesSupposes.com (shortcut syntax created by Zeh Fernando, Ladislav Zigo, others) * @version	2.1.4*/class com.mosesSupposes.fuse.Shortcuts {	/**	 * @exclude	 * Unique identifier used by ZigoEngine.register	 */ 	public static var registryKey:String = 'shortcuts';		/**	 * @exclude	 * An internal memory object that stores all shortcut methods & properties for quick access.	 */ 	public static var shortcuts:Object = null;		/**	 * @exclude	 * An internal memory object that stores all MovieClip-specific shortcut methods & properties for quick access.	 */ 	public static var mcshortcuts:Object = null;		/**	* @exclude	* A relay that ensures initShortcuts has been called, also called by <code>ZigoEngine.register()</code> to ensure class is imported and retained.	*/	public static function initialize():Void	{		if (shortcuts==null) initShortcuts();	}		/**	* @exclude	* Enables shortcut syntax with doTween. (This idea thanks to Yotam Laufer)	* @param obj			target of tween	* @param methodName		method type to tween	*/	public static function doShortcut(obj:Object, methodName:String):String	{		initialize();		var s:Function = shortcuts[methodName];		if (s==undefined) {			if (typeof obj=='movieclip') s = mcshortcuts[methodName];		}		if (s==undefined) return null;		obj = arguments.shift();		methodName = String(arguments.shift());		if (!(obj instanceof Array)) obj = [obj];		var propsAdded:String = '';		for (var i:String in obj) {			var pa:String = String((s.apply(obj[i], arguments)));			if (pa!=null && pa.length>0) {				if (propsAdded.length>0) propsAdded=(pa+'|'+propsAdded);				else propsAdded = pa;			}		}		return ((propsAdded=='') ? null : propsAdded);	}		/**	* @exclude	* ZigoEngine uses this method to graft shortcut methods and properties into one or more target objects.	* @params		 accepts any number of target objects	*/	public static function addShortcutsTo():Void	{		initialize();		var doadd:Function = function(o:Object,so:Object) {			for (var j:String in so) {				var item:Object = so[j];				if (item.getter || item.setter) {					o.addProperty(j, item.getter, item.setter);					_global.ASSetPropFlags(o, j, 3, 1); // must remain overwritable for direct initialization of individual targets.				}				else {					o[j] = item;					_global.ASSetPropFlags(o, j, 7, 1);				}			}		};		for (var i:String in arguments) {			var obj:Object = arguments[i];			// add MovieClip-only shortcuts			if (obj==MovieClip.prototype || typeof obj=='movieclip') {				doadd(obj,mcshortcuts);			}			doadd(obj,shortcuts);		}	}		/**	* @exclude	* ZigoEngine uses this method to strip shortcut methods and properties from one or more target objects.	* @params		accepts any number of target objects	*/	public static function removeShortcutsFrom():Void	{		initialize();		var doremove:Function = function(o:Object,so:Object):Void {			for (var j:String in so) {				_global.ASSetPropFlags(o, j, 0, 2); // 0,2 is NOT a mistake, do not change				var item:Object = so[j];				if (item.getter || item.setter) {					o.addProperty(j,null,null); 				}				delete o[j];			}		};		for (var i:String in arguments) {			var obj:Object = arguments[i];			// remove MovieClip-only shortcuts			if (obj==MovieClip.prototype || typeof obj=='movieclip') {				doremove(obj,mcshortcuts);			}			doremove(obj,shortcuts);		}	}		/**	* @exclude	* The "easyfunc" syntax feature of the Kit, in which a string version of a complete callback like <code>"_root.gotoAndStop('home');"</code> is parsed, is stored in the Shortcuts class. If an easyfunc string is passed when Shortcuts has not been registered, a warning message is thrown. 	* @param callbackStr	complete version of the callback	* @return object	*/	public static function parseStringTypeCallback(callbackStr:String):Object	{		var evaluate:Function = function(val:String):Object { 			var first:String = val.charAt(0);			if (first==val.slice(-1) && (first=='"' || first=="'")) return val.slice(1,-1); // retain quoted values as strings			if (val=='true') return Object(true);			if (val=='false') return Object(false);			if (val=='null') return Object(null);			if (_global.isNaN(Number(val))==false) return Object(Number(val));			return Object(eval(val)); // otherwise assume it's an expression, use eval to convert.		};		var trimWhite:Function = function(str:String):String {			while(str.charAt(0)==' ') str = str.slice(1);			while(str.slice(-1)==' ') str = str.slice(0,-1);			return str;		};		var evaluateList:Function = function(list:Array):Array {			var newlist:Array = [];			for (var i:Number=0; i<list.length; i++) {				var item:String = list[i];				item = trimWhite(item);				var isObj:Boolean = (item.charAt(0)=='{' && (item.indexOf('}')>-1 || item.indexOf(':')>-1));				var isArray:Boolean = (item.charAt(0)=='[');				if ((isObj || isArray)==true) {					var o:Object = (isObj==true) ? {} : [];					for (var k:Number=i; k<list.length; k++) {						if (k==i) item = item.slice(1);						var item2:String;						var isEnd:Boolean = (item2.slice(-1)==((isObj==true) ? '}':']') || k==list.length-1);						if (isEnd==true) item2 = item2.slice(0,-1);						if (isObj==true && item2.indexOf(':')>-1) {							var oParts:Array = item2.split(':');							o[trimWhite(oParts[0])] = evaluate(trimWhite(oParts[1]));						}						else if (isArray==true) {							o.push(evaluate(trimWhite(item2)));						}						if (isEnd==true) {							newlist.push(o);							i = k; // fake out loop							break;						}					}				}				else {					newlist.push(evaluate(trimWhite(item)));				}			}			return newlist;		};		var parts:Array = callbackStr.split( "(" );		var p0:String = parts[0];		var p1:String = parts[1];		return { func:(p0.slice(p0.lastIndexOf(".")+1)),					 scope:eval(p0.slice(0,p0.lastIndexOf("."))),					 args:(evaluateList((p1.slice(0, p1.lastIndexOf(")"))).split(","))) };		/* @ignore */	}		/**	* @exclude	* Internal method that writes all shortcuts into a memory object, creating fast access for copying the set or locating a specific method for a <code>ZigoEngine.doShortcuts</code> call.	*/	private static function initShortcuts():Void	{		shortcuts = (new Object());		// methods which pass all standard arguments through are auto-generated		var methods:Object = {	alphaTo:'_alpha',								scaleTo:'_scale',								sizeTo:'_size',								rotateTo:'_rotation',								brightnessTo:'_brightness',								brightOffsetTo:'_brightOffset',								contrastTo:'_contrast',								colorTo:'_tint',								tintPercentTo:'_tintPercent',								colorResetTo:'_colorReset',								invertColorTo:'_invertColor' };		var fmethods:Array = _global.com.mosesSupposes.fuse.FuseFMP.getAllShortcuts(); // if FMP exists, graft a bunch more shortcuts.		var okFmethods:Object = {blur:1,blurX:1,blurY:1,strength:1,shadowAlpha:1,highlightAlpha:1,angle:1,distance:1,alpha:1,color:1};		for (var i:String in fmethods) if (okFmethods[(fmethods[i]).split('_')[1]]===1) methods[fmethods[i]+'To'] = fmethods[i];		var ro:Object = {			__resolve:function(name:String):Function {				var propName:String = methods[name];				return (function():String {					var rs:String = (_global.com.mosesSupposes.fuse.ZigoEngine.doTween.apply(ZigoEngine, ((new Array(this, propName)).concat(arguments))));					return rs;				});			}		};		// also auto-generate getter/setters which are all similar		var ro2:Object = {			__resolve:function(name:String):Object {				var returnObj:Object = { setter:function(v:Object) { _global.com.mosesSupposes.fuse.ZigoEngine.doTween((this),((name=='_tintString')?'_tint':name),v,0); } };				switch (name) {					case '_colorReset' : 	returnObj.getter = function():Number { return (100 - (_global.com.mosesSupposes.fuse.ZigoEngine.getColorKeysObj(this))['tintPercent']); }; break;					case '_colorTransform':	returnObj.getter = function():Object { return Color(new Color(this)).getTransform(); }; break;					case '_fade' : 			returnObj.getter = function():Number { return (this)._alpha; }; break;					case '_size' : 			returnObj.getter = function():Number { return (((this)._width==(this)._height) ? (this)._width : null); }; break;					case '_scale' : 		returnObj.getter = function():Number { return (((this)._xscale==(this)._yscale) ? (this)._xscale : null); }; break;					default: 				returnObj.getter = function():Object { return (_global.com.mosesSupposes.fuse.ZigoEngine.getColorKeysObj(this))[name.slice(1)]; };				}				return returnObj;			}		};		for (var i:String in methods) {			shortcuts[i] = ro[i];			if (i!='alphaTo' && i!='rotateTo') {				shortcuts[methods[i]] = ro2[methods[i]];			}		}		shortcuts._tintString = ro2['_tintString'];		shortcuts._colorTransform = ro2['_colorTransform'];		shortcuts._fade = ro2['_fade'];				shortcuts.tween = function(props:Object, endVals:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String { // references the method.			if (arguments.length==1 && typeof props=='object') {				return (ZigoEngine.doTween({ target:this, action:props }));			}			return (ZigoEngine.doTween(this, props, endVals, seconds, ease, delay, callback));		};				shortcuts.removeTween = shortcuts.stopTween = function(props:Object):Void {			com.mosesSupposes.fuse.ZigoEngine.removeTween(this,props);		};				shortcuts.removeAllTweens = shortcuts.stopAllTweens = function():Void { // globally remove all tweens from a clip			com.mosesSupposes.fuse.ZigoEngine.removeTween('ALL');		};				shortcuts.isTweening = function(prop:String):Boolean {			return ZigoEngine.isTweening(this, prop);		};				shortcuts.getTweens = function():Number {			return ZigoEngine.getTweens(this);		};				shortcuts.lockTween = function():Void {			com.mosesSupposes.fuse.ZigoEngine.lockTween(this, true);		};				shortcuts.unlockTween = function():Void {			com.mosesSupposes.fuse.ZigoEngine.lockTween(this, false);		};				shortcuts.isTweenLocked = function():Boolean {			return ZigoEngine.isTweenLocked(this);		};				shortcuts.isTweenPaused = function(prop:String):Boolean { 			return ZigoEngine.isTweenPaused(this, prop);		};				shortcuts.pauseTween = function(props:Object):Void { 			com.mosesSupposes.fuse.ZigoEngine.pauseTween(this,props);		};				shortcuts.resumeTween = shortcuts.unpauseTween = function(props:Object):Void {			com.mosesSupposes.fuse.ZigoEngine.unpauseTween(this,props);		};				shortcuts.pauseAllTweens = function():Void { // globally pause all tweens from a clip			com.mosesSupposes.fuse.ZigoEngine.pauseTween('ALL');		};				shortcuts.resumeAllTweens = shortcuts.unpauseAllTweens = function():Void { // globally unpause all tweens from a clip			com.mosesSupposes.fuse.ZigoEngine.unpauseTween('ALL');		};				shortcuts.ffTween = function(props:Object):Void {			com.mosesSupposes.fuse.ZigoEngine.ffTween(this,props);		};				shortcuts.rewTween = function(props:Object,suppressStartEvents:Boolean):Void {			com.mosesSupposes.fuse.ZigoEngine.rewTween(this,props,false,suppressStartEvents);		};				shortcuts.rewAndPauseTween = function(props:Object,suppressStartEvents:Boolean):Void {			com.mosesSupposes.fuse.ZigoEngine.rewTween(this,props,true,suppressStartEvents);		};				shortcuts.skipTweenTo = function(seconds:Number,props:Object):Void {			com.mosesSupposes.fuse.ZigoEngine.skipTweenTo(seconds, this, props);		};				shortcuts.bezierTo = function(destX:Object, destY:Object, controlX:Object, controlY:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String {			return (ZigoEngine.doTween(this, '_bezier_', {x:destX,y:destY,controlX:controlX,controlY:controlY}, seconds, ease, delay, callback));		};				shortcuts.colorTransformTo = function(ra:Object, rb:Object, ga:Object, gb:Object, ba:Object, bb:Object, aa:Object, ab:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String {			return (ZigoEngine.doTween(this, '_colorTransform',{ra:ra, rb:rb, ga:ga, gb:gb, ba:ba, bb:bb, aa:aa, ab:ab}, seconds, ease, delay, callback));		};				shortcuts.tintTo = function(rgb:Object, percent:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String {			return (ZigoEngine.doTween(this, '_tint', {tint:rgb, percent:percent}, seconds, ease, delay, callback));		};				shortcuts.slideTo = function(destX:Object, destY:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String {			return (ZigoEngine.doTween(this, '_x,_y', [destX,destY], seconds, ease, delay, callback));		};				// _fade tweens are a proxy for _alpha that toggle the target's _visible property when _alpha reaches 0 / 100.		shortcuts.fadeIn = function(seconds:Number, ease:Object, delay:Number, callback:Object):String {			return (ZigoEngine.doTween(this, '_fade', 100, seconds, ease, delay, callback));		};				shortcuts.fadeOut = function(seconds:Number, ease:Object, delay:Number, callback:Object):String {			return (ZigoEngine.doTween(this, '_fade', 0, seconds, ease, delay, callback));		};				mcshortcuts = (new Object());				mcshortcuts._frame = {			getter:function():Number { return (this)._currentframe; },			setter:function(v:Number) { (this).gotoAndStop(Math.round(v)); }		};				mcshortcuts.frameTo = function(endframe:Object, seconds:Number, ease:Object, delay:Number, callback:Object):String {			return (ZigoEngine.doTween((this), "_frame", ((endframe!=undefined) ? endframe : (this)._totalframes), seconds, ease, delay, callback));		};	}}