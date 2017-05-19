package ya.component.message
{
	import flash.text.TextField;
	
	import ya.component.YaSprite;
	import ya.manages.FrameRenderManager;
	import ya.manages.LayerManager;
	import ya.utils.YaFactory;
	
	public class MessageItem extends YaSprite
	{
		private var _txt:TextField;
		public function MessageItem()
		{
			_txt=YaFactory.getTextFied({"filter":true});
			this.addChild(_txt);
		}
		
		public function setObj(obj:String):MessageItem{
			_txt.htmlText=obj;
			return this;
		}
		
		private var _startY:int;
		public function start(x_:int,y_:int):void{
			_g=1;
			this.y=y_;
			this.x=x_;
			_startY=y_;
			FrameRenderManager.instance.add(frameAction);
			LayerManager.Layer_Message.addChild(this);
		}
		
		private var _g:Number=1;
		public function frameAction():void{
			_g+=.2;
			this.y-=_g;
			if(this.y<_startY-100){
				FrameRenderManager.instance.remove(frameAction);
				MessageManager.instance.push(this);
				this.parent&&this.parent.removeChild(this);
			}
		}
	}
}