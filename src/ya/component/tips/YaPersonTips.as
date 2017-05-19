package ya.component.tips
{
	import flash.display.MovieClip;
	
	import ya.component.YaResName;
	import ya.manages.ResManager;
	import ya.manages.UrlManager;

	public class YaPersonTips extends YaBaseTips
	{
		public function YaPersonTips(url:String=null)
		{
			this.graphics.beginFill(0xaaaaaa);
			this.graphics.drawRect(0,0,105,91);
			this.graphics.endFill();
			
			super(UrlManager.instance.getResUrl(YaResName.PersonWalkRes));
		}
		
		private var walk:MovieClip;
		override protected function resManagerCall():void{
			walk=ResManager.instance.getInstanceObj("PersonWalkRes3","PersonWalkRes.swf") as MovieClip;
			this.addChild(walk);
			this.height=91;
		}
		
		override public function destroy():void{
			super.destroy();
			walk.stop();
			walk=null;
		}
	}
}