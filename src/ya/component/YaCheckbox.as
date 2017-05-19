package ya.component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ya.interfaces.ISelecte;
	import ya.manages.UrlManager;
	
	public class YaCheckbox extends YaSprite implements ISelecte
	{
		private var _state:int=0;
		private var _yaImageProxyArr:Array=[];
		
		public function YaCheckbox()
		{
			super();
		}
		
		public function setSkin(...args):void{
			var yaImageProxy:YaImageProxy;
			for(var i:int=0;i<args.length;i++){
				yaImageProxy=new YaImageProxy(UrlManager.instance.getBtnResUrl(args[i]));
				this.addChild(yaImageProxy);
				_yaImageProxyArr.push(yaImageProxy);
				yaImageProxy.alpha=0;
			}
			addEvent();
			setSelectedState(0);
		}
		
		public function setSelectedState(val:int):void{
			_state=val;
			var yaImageProxy:YaImageProxy;
			for(var i:int=0;i<4;i++){
				yaImageProxy=_yaImageProxyArr[i];
				if(yaImageProxy){
					if(i==val){
						yaImageProxy.alpha=1;
					}else{
						yaImageProxy.alpha=0;
					}
				}
			}
		}
		
		private var _group:YaGroup;
		public function register(group:YaGroup):void{
			_group=group;
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
			if(e.type==MouseEvent.MOUSE_DOWN){
				if(_group){
					_group.setSelected(this);
					return;
				}
				setSelectedState(_state==0?1:0);
			}
		}
		
		public function getSelectedState():int{
			return _state;
		}
		public function getKey():Object{
			return null;
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}