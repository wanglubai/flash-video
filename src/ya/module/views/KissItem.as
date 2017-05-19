package ya.module.views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import ya.component.YaCacheSprite;
	import ya.manages.LayerManager;
	import ya.manages.ResManager;
	import ya.manages.UrlManager;
	
	public class KissItem extends YaCacheSprite
	{
		public function KissItem(url:String=null)
		{
			super(UrlManager.instance.getResUrl('Gift_Kill_Res.swf'));
			this.mouseChildren=false;
			this.mouseEnabled=false;
			
			LayerManager.Layer_UI.addChild(this);
		}
		
		private var _mc:MovieClip;
		override protected function initView():void{
			_mc=ResManager.instance.getInstanceObj("Gift_Kill_Res","Gift_Kill_Res.swf");
			_mc.gotoAndPlay(1);
			this.addChild(_mc);
			
			_mc.addEventListener("stop",stopFun);
		}
		
		private function stopFun(e:Event):void{
			_mc.stop();
			this.parent&&this.parent.removeChild(this);
		}
	}
}