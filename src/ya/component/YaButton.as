package ya.component
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ya.manages.UrlManager;
	import ya.utils.YaFactory;
	
	public class YaButton extends YaSprite
	{
		private var _state:int=0;
		private var _statusSkinArr:Array=[];
		
		public function YaButton()
		{
			super();
		}
		
		public function setSkin(...args):void{
			var element:Object;
			for(var i:int=0;i<args.length;i++){
				element=args[i];
				if(element is String){
					var yaImageProxy:YaImageProxy=new YaImageProxy(UrlManager.instance.getBtnResUrl(args[i]));
					this.addChild(yaImageProxy);
					_statusSkinArr.push(yaImageProxy);
				}else if(element is DisplayObject){
					this.addChild(element as DisplayObject);
					_statusSkinArr.push(element);  
				}
			}
			
			addEvent();
			setState(0);
		}
		
		public function setState(val:int):void{
			_state=val;
			var len:int=_statusSkinArr.length;
			for(var i:int=0;i<len;i++){
				if(_statusSkinArr[i]){
					if(i==val){
						_statusSkinArr[i].alpha=1;
					}else{
						_statusSkinArr[i].alpha=0;
					}
				}
			}
		}
		
		override protected function addEvent():void{
			this.buttonMode=true;
			
			this.addEventListener(MouseEvent.MOUSE_OVER,eventFun);
			this.addEventListener(MouseEvent.MOUSE_OUT,eventFun);
			this.addEventListener(MouseEvent.MOUSE_UP,eventFun);
			this.addEventListener(MouseEvent.MOUSE_DOWN,eventFun);
		}
		
		override protected function removeEvent():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER,eventFun);
			this.removeEventListener(MouseEvent.MOUSE_OUT,eventFun);
			this.removeEventListener(MouseEvent.MOUSE_UP,eventFun);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,eventFun);
		}
		
		private function eventFun(e:Event):void{
			if(e.type==MouseEvent.MOUSE_OVER){
				setState(1);
			}else if(e.type==MouseEvent.MOUSE_DOWN){
				_statusSkinArr[2]?setState(2):setState(0);
			}else if(e.type==MouseEvent.MOUSE_UP){
				setState(0);
			}else if(e.type==MouseEvent.MOUSE_OUT){
				setState(0);
			}
		}

		override public function destroy():void{
			removeEvent();
			var el:Object;
			while(_statusSkinArr.length>0){
				el=_statusSkinArr.pop();
				this.removeChild(el as DisplayObject);
				if(el is MovieClip){
					(el as MovieClip).stop();
				}else if(el is YaImageProxy){
					(el as YaImageProxy).destroy();
				}
			}
		}
	}
}