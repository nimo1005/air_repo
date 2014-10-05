package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Calculator extends MovieClip 
	{
		private static var _instance:Calculator;
		private var class_path:MovieClip;
		private var _txt_path:Object;
		private var _max_length:uint = 2;
		
		public function Calculator() 
		{
			class_path = this;
			
			numberBtn_0.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_1.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_2.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_3.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_4.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_5.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_6.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_7.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_8.addEventListener(MouseEvent.CLICK, numberBtnClick);
			numberBtn_9.addEventListener(MouseEvent.CLICK, numberBtnClick);
			clear_btn.addEventListener(MouseEvent.CLICK, clearBtnClick);
			close_btn.addEventListener(MouseEvent.CLICK, closeBtnClick);
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
		
		
		private function closeBtnClick(e:MouseEvent):void
		{
			Object(parent).removeChild(class_path);
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
		
		
	}
	
}
