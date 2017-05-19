package ya.module.views.system.heart
{
	import ya.component.YaImageProxy;
	import ya.component.YaSprite;
	import ya.manages.LayerManager;
	import ya.manages.UrlManager;
	import ya.module.views.barrage.manager.BarrageRenderManager;
	
	public class HeartItem extends YaSprite
	{
		private var _heartImg:YaImageProxy;
		public function HeartItem()
		{
			initStage();
			_heartImg=new YaImageProxy(UrlManager.instance.getResUrl('heart'+int(Math.random()*4+1)+'.png'));
			_heartImg.IsCenter=true;
			this.addChild(_heartImg);
			
			LayerManager.Layer_Barrage.addChild(this);
		}
		
		private var xVal:int;
		private var _speed:Number=3;
		private var _g:Number=0.02;
		public function start():void{
			this.alpha=0.5;
			_speed=Math.random()*2;
			this.x=_stage.stageWidth-100+Math.random()*50;
			this.scaleX=this.scaleY=0.1;
			this.y=_stage.stageHeight-20;
			this.xVal=Math.random()*10-5;
			BarrageRenderManager.instance.add(frameAction);
		}
		
		private function frameAction():void{
			if(this.scaleX<0.5){
				this.scaleY=this.scaleX+=0.05;
				this.y-=5;
			}else{
				this.y-=(_speed+=_g);
			}
			if(this.y>400){
				this.alpha+=0.02;
			}
			if(this.y<200){
				BarrageRenderManager.instance.remove(frameAction);
				this.parent&&this.parent.removeChild(this);
			}
			if(this.y<300){
				this.alpha-=0.02;
			}
		}
		
		override public function destroy():void{
			BarrageRenderManager.instance.remove(frameAction);
			LayerManager.Layer_UI.removeChild(this);
			_heartImg.destroy();
		}
	}
}