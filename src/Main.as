package
{
	import com.junkbyte.console.Cc;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ya.component.YaSprite;
	import ya.component.loads.XmlLoader;
	import ya.manages.ConfigManager;
	import ya.manages.ControllerManager;
	import ya.manages.LayerManager;
	import ya.manages.LogManager;
	import ya.manages.UrlManager;
	import ya.module.controller.PlayerController;
	import ya.module.model.player.PlayerModel;
	
	[SWF(backgroundColor="0x000000", width="1280", height="768")]
	public class Main extends Sprite
	{
		public function Main(){
			this.addEventListener(Event.ADDED_TO_STAGE,addStageFun);
		}
		
		private function addStageFun(e:Event):void{
			init();
		}
		
		private function init():void{
			initTool();
			LayerManager.init(this.stage);
			ControllerManager.instance.init();
			ControllerManager.instance.test();
//			PlayerController.instance.initWebParamVo(thisParam);
		}
		
		private function xmlcomplete(obj:Object):void{
			PlayerController.instance.initVideoVoByXml(new XML(obj));
		}
		
		private function initTool():void{
			LogManager.register(this.stage);
		}
		
		private function get thisParam():Object{
			return this.loaderInfo.parameters;
		}
	}
}