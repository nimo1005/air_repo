package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author t
	 */
	public class WeightClassBtn extends MovieClip
	{
		private var weight_class_no:int;
		
		public function WeightClassBtn()
		{
			selected_mc.visible = false;
			weight_class_no = Number(this.name.split("_")[1]);
			this.addEventListener(MouseEvent.CLICK, weightClassClick, false, 0, true);
		}
		
		
		private function weightClassClick(e:MouseEvent):void
		{
			MovieClip(parent).unselectedBtn();
			
			if (weight_class_no < LegalCostScene.WEIGHT_CLASS_NO7)
			{
				LegalCostScene.class_path.insuranceBtn1.visible = true;
				LegalCostScene.class_path.insuranceBtn2.visible = false;
			}
			else
			{
				LegalCostScene.class_path.insuranceBtn1.visible = false;
				LegalCostScene.class_path.insuranceBtn2.visible = true;
			}
			
			LegalCostScene.class_path.insuranceBtn1.initCount(LegalCostScene.class_path.INSURANCE_24M);
			LegalCostScene.class_path.insuranceBtn2.initCount(LegalCostScene.class_path.INSURANCE_12M);
			
			LegalCostScene.class_path.month_txt.text = "";
			LegalCostScene.class_path.amount_txt.text = "";
			
			Object(parent).selectedWeight(weight_class_no);
			selectedColor();
			
		}
		
		public function selectedColor():void
		{
			selected_mc.visible = true;
		}
		
		public function unselectedColor():void
		{
			selected_mc.visible = false;
		}
	}

}

