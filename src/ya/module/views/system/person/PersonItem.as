package ya.module.views.system.person
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import ya.component.YaCacheSprite;
	import ya.component.YaResName;
	import ya.manages.FrameRenderManager;
	import ya.manages.ResManager;
	import ya.manages.UrlManager;
	
	public class PersonItem extends YaCacheSprite
	{
		public function PersonItem(p:DisplayObjectContainer)
		{
			p.addChild(this);
			initStage();
			super(UrlManager.instance.getResUrl(YaResName.PersonWalkRes));
			this.y=100+Math.random()*300;
			
			this.mouseChildren=false;
			this.mouseEnabled=false;
		}
		
		private var walk:MovieClip;
		override protected function resManagerCall():void{
			walk=ResManager.instance.getInstanceObj("PersonWalkRes3",YaResName.PersonWalkRes) as MovieClip;
			this.addChild(walk);
			//LayerManager.Layer_Advanced_Barrage.addChild(this);
			FrameRenderManager.instance.add(frameAction);
		}
		
		private function frameAction():void{
			this.x+=10;
			if(this.x>_stage.stageWidth){
				destroy();
			}
		}
		override public function destroy():void{
			FrameRenderManager.instance.remove(frameAction);
			walk.stop();
			walk=null;
			this.parent&&this.parent.removeChild(this);
		}
	}
}