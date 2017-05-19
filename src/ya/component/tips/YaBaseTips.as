package ya.component.tips
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import ya.component.YaCacheSprite;
	import ya.manages.LayerManager;
	
	public class YaBaseTips extends YaCacheSprite
	{
		public static const Type_Mouse_XY:String="Type_Mouse_XY";
		public static const Type_Target_XY:String="Type_Target_XY";
		
		public var type:String=Type_Mouse_XY;
		public function YaBaseTips(url:String=null)
		{
			super(url);
			initStage();
		}
		
		public function show():void{
			LayerManager.Layer_Tips.addChild(this);
		}
		
		public function setPosition(x_:Number,y_:Number):void{
			this.x=Math.max(Math.min(x_,_stage.stageWidth-this.width),0);
			this.y=Math.max(y_,0);
		}
		
		public function setTarget(target:DisplayObject):void{
		}
		
		public function hide():void{
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
		public function setObj(obj:Object):YaBaseTips{
			return this;
		}
		
		override public function destroy():void{
			hide();
		}
	}
}