package ya.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class YaUtils
	{
		public static function setCenterByDisplayObject(dis:DisplayObject):void{
			if(dis.parent){
				dis.x=(dis.parent.width-dis.width)/2;
				dis.y=(dis.parent.height-dis.height)/2;
			}
		}
		
		public static function setCenterByTargets(dis:DisplayObject,dis1:DisplayObject):void{
			dis.x=(dis1.width-dis.width)/2;
			dis.y=(dis1.height-dis.height)/2;
		}
		
		public static function setCenterByTargetsWD(dis:DisplayObject,w:Number,h:Number):void{
			dis.x=(w-dis.width)/2;
			dis.y=(h-dis.height)/2;
		}
		
		public static function setCenterX(target:DisplayObject,reference:DisplayObject):void{
			target.x=(reference.width-target.width)/2;
		}
		
		public static function setCenterY(target:DisplayObject,reference:DisplayObject):void{
			target.y=(reference.height-target.height)/2;
		}
		
		public static function secToTime ( secs:int ):String { 
			var h:int = Math.floor ( secs / 3600); 
			var m:int = Math.floor ( ( secs - h * 3600 ) / 60 ); 
			var s:int = secs - h * 3600 - m * 60; 
			return h + ":" + m + ":" + s; 
		} 
		
		public static function setGraphics(target:Sprite,w:Number,h:Number,color:int=0x990000):Sprite{
			target.graphics.clear();
			target.graphics.beginFill(color);
			target.graphics.drawRect(0,0,w,h);
			target.graphics.endFill();
			return target;
		}
		
		public static function getSprite(w:Number,h:Number,color:int=0x990000):Sprite{
			return setGraphics(new Sprite(),w,h,color);
		}
	}
}