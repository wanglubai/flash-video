package ya.component.tips
{
	import flash.text.TextField;
	
	import ya.utils.YaFactory;

	public class YaTxtTips extends YaBaseTips
	{
		private var _txt:TextField;
		public function YaTxtTips(describe:String="",url:String=null)
		{
			_txt=YaFactory.getTextFied({});
			this.addChild(_txt);
			super(url);
			
			if(describe&&describe!=""){
				setObj(describe);
			}
		}
		
		override public function setObj(obj:Object):YaBaseTips{
			_txt.htmlText=obj.toString();
			
			this.graphics.beginFill(0x990000);
			this.graphics.drawRect(0,0,_txt.width,_txt.height);
			this.graphics.endFill();
			
			return this;
		}
		
		override public function destroy():void{
			super.destroy();
			_txt=null;
		}
	}
}