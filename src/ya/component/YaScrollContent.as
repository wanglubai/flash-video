package ya.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ya.utils.YaUtils;

	public class YaScrollContent extends YaSprite
	{
		private var _bg:Sprite;
		private var _content:Sprite;
		private var _mask:Sprite;
		private var _speed:int=15;
		private var _progressVal:Number=0; 
		private var _progressChangeCallFun:Function;
		
		private var _attributeObj:Object={"x":"x","width":"width"};
		public function setVertical():void{
			_attributeObj={"x":"y","width":"height"}
		}
		public function YaScrollContent(w:int,h:int)
		{
			_bg=YaUtils.getSprite(w,h);
			this.addChild(_bg);
			
			_mask=YaUtils.getSprite(w,h);
			this.addChild(_mask);
			
			_content=new Sprite();
			this.addChild(_content);
			
			_content.mask=_mask;
			
			addEvent();
		}
		
		override protected function addEvent():void{
			this.addEventListener(MouseEvent.MOUSE_WHEEL,eventFun);
		}
		
		override protected function removeEvent():void{
			this.removeEventListener(MouseEvent.MOUSE_WHEEL,eventFun);
		}
		
		private function eventFun(e:Event):void{
			if(e.type==MouseEvent.MOUSE_WHEEL){
				if (MouseEvent(e).delta < 0){
					_content[_attributeObj["x"]]=Math.max(_content[_attributeObj["x"]]-_speed,_mask[_attributeObj["width"]]-_content[_attributeObj["width"]]);
				}else{
					_content[_attributeObj["x"]]=Math.min(0,_content[_attributeObj["x"]]+_speed);
				}
				_progressVal=-(_content[_attributeObj["x"]]/(_content[_attributeObj["width"]]-_mask[_attributeObj["width"]]));
				if(_progressChangeCallFun!=null){
					_progressChangeCallFun();
				}
			}
		}
		
		private function refresh():void{
			_content[_attributeObj["x"]]=Math.min(0,-(_content[_attributeObj["width"]]-_mask[_attributeObj["width"]])*_progressVal);
		}
		
		public function push(sp:Sprite):void{
			_content.addChild(sp);
			refresh();
		}
		public function remove(sp:Sprite):void{
			_content.contains(sp)&&_content.removeChild(sp)&&refresh();
		}
		public function progressChangeCallFun(fun:Function):void{
			_progressChangeCallFun=fun;
		}
		public function set setProgressVal(val:Number):void{
			_progressVal=val;
			refresh();
		}
		public function get getProgressVal():Number{
			return _progressVal;
		}
		
		override public function destroy():void{
			removeEvent();
			_progressChangeCallFun=null;
			_bg=null;
			_content=null;
			_mask=null;
		}
	}
}
