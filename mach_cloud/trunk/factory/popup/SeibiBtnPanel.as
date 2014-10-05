package  
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.utils.getDefinitionByName;
	
	public class SeibiBtnPanel extends MovieClip 
	{
		private var storeManage:StoreManage;
		private var _userManage:UserManage;
		private const CLASS_NAME:Array = ["SelectSeibiBtn", "IntInputBtn", "DecimalPointBtn", "SelectSeibiBtn"];
		
		private var SPACE_H:Number = 3; //ボタン同士の間隔
		private var SPACE_W:Number = 10; //ボタン同士の間隔
		private var INIT_Y:Number = 0; //初期位置 Y
		private var INIT_X:Number = 0; //初期位置 X
		private var MAX_ROW:Number = 13; //表示できる行の数		
		
		public function SeibiBtnPanel() 
		{
			storeManage = StoreManage.getInstance();
			_userManage = UserManage.getInstance();
			
			callSeibiList();
		}
		
		private function callSeibiList():void
		{
			var obj:Array = new Array();
			obj.db_name = storeManage.dbName();
			obj.mot_id = _userManage.motid();
			obj.mt_id = _userManage.mtid();
			obj.mdms_id = SelectedMdmsRow.getSelectedInfo()["mdms_id"];
			Remote.callRemote2("fact.SeibiList", SeibiListResult, obj);
		}
		
		/*
		 * タイル状に整備ボタンを並べる 
		*/
		private function SeibiListResult(e:Object):void
		{

			for(var i:uint = 0; i < e.length; i++)
			{
				var class_name:String = className(Number(e[i]["chk_qt"]));
				var ClassRef:Class = Class(getDefinitionByName(class_name));
				var classBtn = new ClassRef();
				
				classBtn.setupBtn(e[i]);
				
				var rowCnt = i % MAX_ROW;
				var columnCnt = Math.floor(i / MAX_ROW);
				
				classBtn.y = INIT_Y + (rowCnt * (classBtn.height + SPACE_H));
				classBtn.x = INIT_X + (columnCnt * (classBtn.width + SPACE_W));
				this.addChild(classBtn);
			}
		}
		
		
		/*
		 * chk_qtはボタンの種類をあらわす番号
		 * chk_qtによって、選択するボタンや数値入力するボタンを生成している
		*/
		private function className(chk_qt:uint):String
		{
			return CLASS_NAME[chk_qt];
		}
		
	}
	
}
