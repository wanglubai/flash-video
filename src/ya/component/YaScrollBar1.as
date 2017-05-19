package ya.component
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class YaScrollBar1 extends YaCacheSprite
	{
		public function YaScrollBar1(url:String=null)
		{
			super(url);
		}
		
		private var _attributeObj:Object={"move":"x","Fixed":"y"};
		public function setVertical():void{
			_attributeObj={"x":"y","width":"height"}
		}
		private var _barBtn:YaSprite;
		private var _bg:DisplayObject
		override protected function addEvent():void{
			_barBtn.addEventListener(MouseEvent.MOUSE_DOWN, eventFun);
			_bg.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
		}
		private function eventFun(e:Event):void{
			if(e.currentTarget==_barBtn){
				_barBtn.startDrag(false, new Rectangle(0, 0,_barBtn.x,_maxVal)); 
			}else if(e.currentTarget==_bg){
				
			}
		}
		private function getRectangle():Rectangle{
			if(_attributeObj['move']=="x"){
				new Rectangle(0,0,_ma,1);
			}
		}
	}
}