package ya.manages
{
	import com.junkbyte.console.Cc;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ya.component.YaLayer;

	/**
	 * 层级管理器 
	 * @author wangshuang
	 * 
	 */
	public class LayerManager
	{
		public static var Layer_Video:YaLayer;
		public static var Layer_Barrage:YaLayer;
		public static var Layer_Temp_Barrage:YaLayer;
		public static var Layer_Advanced_Barrage:YaLayer;
		public static var Layer_UI:YaLayer;
		public static var Layer_Tips:YaLayer;
		public static var Layer_Message:YaLayer;
		public static var Layer_Stage:Stage;
		public static function init(root:DisplayObjectContainer):void{
			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(0xeeeeee);
			sp.graphics.drawRect(0,0,ConfigManager.W_video,ConfigManager.H_video);
			sp.graphics.endFill();
			root.addChild(sp);
			
			Layer_Video=new YaLayer();
			root.addChild(Layer_Video);
			
			Layer_Barrage=new YaLayer();
			root.addChild(Layer_Barrage);
			
			Layer_Advanced_Barrage=new YaLayer();
			root.addChild(Layer_Advanced_Barrage);
			
			Layer_Temp_Barrage=new YaLayer();
			root.addChild(Layer_Temp_Barrage);
			
			Layer_UI=new YaLayer();
			root.addChild(Layer_UI);
			
			Layer_Message=new YaLayer();
			root.addChild(Layer_Message);
			
			Layer_Tips=new YaLayer();
			root.addChild(Layer_Tips);
			
			Layer_Stage=Stage(root);
			
			Layer_Stage.showDefaultContextMenu = false;
			Layer_Stage.scaleMode = StageScaleMode.NO_SCALE;
			Layer_Stage.align=StageAlign.TOP_LEFT;
			//Layer_Stage.addEventListener(MouseEvent.RIGHT_CLICK,function stageRightClick():void{});
			
			Layer_Stage.doubleClickEnabled=true;
		}
	}
}