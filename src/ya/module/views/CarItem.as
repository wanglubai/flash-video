package ya.module.views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import ya.component.YaCacheSprite;
	import ya.manages.LayerManager;
	import ya.manages.ResManager;
	import ya.manages.UrlManager;
	
	public class CarItem extends YaCacheSprite
	{
		public function CarItem(url:String=null)
		{
			super(UrlManager.instance.getResUrl('Gift_Car_Res.swf'));
			this.mouseChildren=false;
			this.mouseEnabled=false;
			
			LayerManager.Layer_Barrage.addChild(this);
			initStage();
			this.x=_stage.stageWidth-700;
			this.y=200;
		}

		private var _mc:MovieClip;
		override protected function initView():void{
			_mc=ResManager.instance.getInstanceObj("Gift_Car_Res","Gift_Car_Res.swf");
			_mc.gotoAndPlay(1);
			this.addChild(_mc);
			
			_mc.addEventListener("stop",stopFun);
		}
		
		private function stopFun(e:Event):void{
			_mc.stop();
			this.parent&&this.parent.removeChild(this);
			if(_overFun!=null){
				_overFun();
			}
		}
		
		public var _overFun:Function;
	}
}