package ya.component
{
	import com.junkbyte.console.Cc;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import ya.component.managers.BitManager;
	import ya.manages.LogManager;
	
	public class YaImageProxy extends YaSprite
	{
		private var _key:String="";
		private var _action:Boolean=false;
		private var _bitmap:Bitmap;
		
		public static var loading:Dictionary=new Dictionary();
		
		public function YaImageProxy(key:String="")
		{
			if(key!=""){
				setBitUrlname(key);
			}
		}
		
		public function set enabled(bl:Boolean):void{
			this.mouseChildren=this.mouseEnabled=bl;
		}
		
		public function get key():String{
			return _key;
		}

		private function setBitUrlname(key:String):void{
			_key=key;
			
			if(BitManager.instance.isHasBitmapData(key)){
				initBit();
			}else{
				if(loading[_key]==null){
					loading[_key]=[initBit];
				}else{
					loading[_key].push(initBit);
					return;
				}
				var loader:Loader=new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
				loader.load(new URLRequest(key));
			}
		}
		
		public var IsCenter:Boolean=false;
		
		private function initBit():void{
			_bitmap=new Bitmap(BitManager.instance.getBitmapData(_key));
			_bitmap.smoothing=true;
			this.addChild(_bitmap);
			
			if(IsCenter){
				_bitmap.x=-_bitmap.width/2;
				_bitmap.y=-_bitmap.height/2;
			}
		}
		
		private function loadComplete(e:Event):void{
			LogManager.debug("成功加载图片："+_key);
			
			BitManager.instance.putBitmapData(_key,e.target.content.bitmapData);
			
			var arr:Array=loading[_key];
			while(arr.length>0){
				arr.pop()();
			}
			loading[_key]=null;
			delete loading[_key];
		}
		
		public function removeParent():void{
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
		public function loadError(e:IOErrorEvent):void{
			_bitmap=new Bitmap(new BitmapData(10,10));
			this.addChild(_bitmap);
			LogManager.log(_key);
		}
		
		override public function destroy():void{
			_bitmap.bitmapData.dispose();
			_bitmap=null;
		}
	}
}