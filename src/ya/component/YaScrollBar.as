package ya.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import ya.component.events.EventName;
	import ya.component.events.ParamEvent;
	
	
	public class YaScrollBar extends YaCacheSprite
	{
		public static const Type_Horizontal:String="Type_Horizontal";//横着
		public static const Type_Vertical:String="Type_Vertical";//竖着
		
		private var _type:String="Type_Horizontal";
		
		private var _barBtn:Sprite;
		private var _bg:Sprite;
		private var _maxVal:int=100;
		
		public function YaScrollBar(type:String=Type_Vertical,url:String=null)
		{
			initStage();
			
			_type=type;
		}
		
		public function setSkin(barBtn:Sprite,bg:Sprite,max:int):void{
			_barBtn=barBtn;
			this.addChild(_barBtn);
		
			_bg=bg;
			this.addChildAt(_bg,0);
			
			_maxVal=max;
			
			addEvent();
		}
		
		
		override protected function addEvent():void{
			_barBtn.addEventListener(MouseEvent.MOUSE_DOWN, eventFun);
			_bg.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
		}
		
		private function eventFun(e:Event):void{
			if(e.currentTarget==_barBtn){
				if(e.type==MouseEvent.MOUSE_DOWN){
					if(_type==Type_Horizontal){
						_barBtn.startDrag(false, new Rectangle(0,_barBtn.y,_maxVal,0));
					}else if(_type==Type_Vertical){
						_barBtn.startDrag(false, new Rectangle(_barBtn.x,0,0,_maxVal));
					}
					_stage.addEventListener(MouseEvent.MOUSE_UP, eventFun);
					_stage.addEventListener(MouseEvent.MOUSE_MOVE,eventFun);
				}
			}else if(e.currentTarget==_bg){
				if(_type==Type_Horizontal){
					_barBtn.x=Math.max(Math.min(Sprite(e.currentTarget).mouseX,_maxVal),0);
					this.dispatchEvent(new ParamEvent(EventName.YaScrollBar_Val,Number(_barBtn.x/_maxVal)));
				}else if(_type==Type_Vertical){
					_barBtn.y=Math.max(Math.min(Sprite(e.currentTarget).mouseY,_maxVal),0);
					this.dispatchEvent(new ParamEvent(EventName.YaScrollBar_Val,Number(_barBtn.y/_maxVal)));
				}
				
			}else if(e.currentTarget==_stage){
				if(e.type==MouseEvent.MOUSE_UP){
					_stage.removeEventListener(MouseEvent.MOUSE_UP, eventFun);
					_stage.removeEventListener(MouseEvent.MOUSE_MOVE,eventFun);
					_barBtn.stopDrag();
				}else if(e.type==MouseEvent.MOUSE_MOVE){
					if(_type==Type_Horizontal){
						this.dispatchEvent(new ParamEvent(EventName.YaScrollBar_Val,Number(_barBtn.x/_maxVal)));
					}else if(_type==Type_Vertical){
						this.dispatchEvent(new ParamEvent(EventName.YaScrollBar_Val,Number(_barBtn.y/_maxVal)));
					}
				}
			}
		}
		
		public function getVal():Number{
			if(_type==Type_Horizontal){
				return Number(_barBtn.x/_maxVal);
			}else{
				return Number(_barBtn.y/_maxVal);
			}
		}
		
		public function setVal(num:Number):void{
			var val:int=num*_maxVal;
			if(_type==Type_Horizontal){
				if(_barBtn)_barBtn.x=val;
			}else {
				if(_barBtn)_barBtn.y=val;
			}
		}
		
		public function get barBtn():Sprite{
			return _barBtn;
		}
	}
}