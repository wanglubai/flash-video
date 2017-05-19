package ya.module.views.barrage
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	import ya.component.YaImageProxy;
	import ya.manages.LayerManager;
	import ya.manages.UrlManager;
	import ya.module.model.barrage.vo.BarrageVo;
	import ya.utils.YaFactory;
	import ya.utils.YaUtils;

	public class BarrageRightTxtItem extends BarrageBaseItem
	{
		private var _txt:TextField;
		private var im:YaImageProxy;
		public function BarrageRightTxtItem()
		{
			if(Math.random()>0.8){
				im=new YaImageProxy(UrlManager.instance.getBtnResUrl('vip.png'));
				this.addChild(im);
			}
			super();
		}
		
		override protected function initView():void{
			_txt=YaFactory.getTextFied({"mouseEnabled":false,'size':24,"filter":true,"color":0xffffff});
			this.addChild(_txt);
			
			if(im){
				_txt.x=60;
			}
			
			addEvent();
		}
		
		override protected function addEvent():void{
			this.addEventListener(MouseEvent.MOUSE_OVER,eventFun);
			this.addEventListener(MouseEvent.MOUSE_OUT,eventFun);
		}
		private function eventFun(e:Event):void{
			if(LayerManager.Layer_Barrage.alpha==0)return;
			if(e.type==MouseEvent.MOUSE_OVER){
				isAction=false;
				this.filters=[new GlowFilter(0xff0000,1,2,2,10)];
				YaUtils.setGraphics(this,this.width,this.height,0x00ff00);
				LayerManager.Layer_Temp_Barrage.addChild(this);
			}else if(e.type==MouseEvent.MOUSE_OUT){
				isAction=true;
				this.filters=[];
				this.graphics.clear();
				LayerManager.Layer_Barrage.addChild(this);
			}
		}
		
		private var isAction:Boolean=true;
		override protected function frameAction():void{
			if(isAction==false){
				return;
			}
			super.frameAction();
		}
		
		override public function setVo(vo:BarrageVo):void{
			_txt.text=vo.uname;
			super.setVo(vo);
		}
	}
}