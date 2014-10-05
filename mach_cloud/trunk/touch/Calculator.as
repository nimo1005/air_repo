package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class Calculator extends MovieClip 
	{
		private static var _instance:Calculator;
		private var class_path:MovieClip;
		private var _txt_path:Object;
		private var _max_length:uint = 7;
		public static const CLOSE_EVENT:String = "close_event";
		
		public function Calculator() 
		{
			class_path = this;
			
			numberBtn_0.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_1.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_2.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_3.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_4.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_5.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_6.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_7.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_8.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			numberBtn_9.addEventListener(MouseEvent.CLICK, numberBtnClick, false, 0, true);
			clear_btn.addEventListener(MouseEvent.CLICK, clearBtnClick, false, 0, true);
			ok_btn.addEventListener(MouseEvent.CLICK, okBtnClick, false, 0, true);
			discountBtn.addEventListener(MouseEvent.CLICK, discountClick, false, 0, true);
		}
		
		public static function getInstance():Calculator 
		{
			if(_instance == null) 
			{
				_instance = new Calculator();
			}
			
			return _instance;
		}
		
		
		private function numberBtnClick(e:MouseEvent):void
		{
			var num:String = e.currentTarget.name.split("_")[1];
			
			if(isInputMaxLength()) return;
			
			_txt_path.text += num;
			
		}
		
		
		private function clearBtnClick(e:MouseEvent):void
		{
			_txt_path.text = "";
		}
		
		
		private function okBtnClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(Calculator.CLOSE_EVENT));
			Object(parent).removeChild(class_path);
			
		}
		
		function discountClick(e:MouseEvent):void
		{
			if(_txt_path.text != "")
			{
				_txt_path.text = Number(_txt_path.text) * -1;		
			}
			else
			{
				_txt_path.text = _txt_path.text + "-";		
			}			
		}
		
		/*
		  * 入力制限
		*/
		private function isInputMaxLength():Boolean
		{
			var len:uint = lengthInputTxt();
			
			if(len == _max_length) 
			{
				return true;
			}
			
			return false;
			
		}
		
		
		/*
		  *
		*/
		public function setMaxLengthTxt(val:uint):void
		{
			_max_length = val;
		}
		
		
		public function setInputTxt(txtPath:Object):void
		{
			_txt_path = txtPath;
		}
		
		
		private function lengthInputTxt():uint
		{
			var txt_path:Object = _txt_path.text;
			return txt_path.length;
		}
		
		public function showDiscount(is_discount:Boolean = false):void
		{
			discountBtn.visible = is_discount;
		}
		
		
	}
	
}
