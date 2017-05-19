package ya.component.poplist
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ya.component.YaGroup;
	import ya.component.YaImageProxy;
	import ya.component.YaSprite;
	import ya.component.tips.YaTipsManager;
	import ya.component.tips.YaTxtTips;
	import ya.interfaces.ISelecte;
	import ya.manages.UrlManager;
	import ya.utils.YaFactory;
	import ya.utils.YaUtils;
	
	public class DemoSelectedItem extends YaSprite implements ISelecte
	{
		private var _state:int=0;
		private var _yaImageProxyArr:Array=[];
		private var _yaGroup:YaGroup;
		private var _txt:TextField;
		public function DemoSelectedItem()
		{
			setInitiativeWH(191,37);
		}
		
		public function setSkin(...args):void{
			var yaImageProxy:YaImageProxy;
			for(var i:int=0;i<args.length;i++){
				yaImageProxy=new YaImageProxy(UrlManager.instance.getBtnResUrl(args[i]));
				this.addChild(yaImageProxy);
				_yaImageProxyArr.push(yaImageProxy);
				yaImageProxy.alpha=0;
			}
			_txt=YaFactory.getTextFied({"width":24,"color":0x000000});
			_txt.mouseEnabled=false;
			this.addChild(_txt);
			addEvent();
			setSelectedState(0);
			
			yaTxtTips=new YaTxtTips();
			YaTipsManager.instance.register(this,yaTxtTips);
		}
		private var yaTxtTips:YaTxtTips;
		public function setText(str:String):void{
			_txt.htmlText=str;
			YaUtils.setCenterByDisplayObject(_txt);
			yaTxtTips.setObj(str);
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
				if(_yaGroup){
					_yaGroup.setSelected(this);
					return;
				}
				setSelectedState(_state?1:0);
			}
		}
		
		public function setSelectedState(val:int):void
		{
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
		
		public function getSelectedState():int
		{
			return 0;
		}
		
		public function register(ya:YaGroup):void
		{
			_yaGroup=ya;
		}
		
		public function getKey():Object
		{
			return _txt.text;
		}
	}
}