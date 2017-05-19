package ya.component.loads
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import ya.manages.LogManager;

	public class XmlLoader extends URLLoader
	{
		private var _fun:Function;
		private var _url:String;
		public function XmlLoader(url:String,callFun:Function)
		{
			_url=url;
			_fun=callFun;
			
			this.addEventListener(Event.COMPLETE,completeFun);
			this.addEventListener(IOErrorEvent.IO_ERROR,errorfun);
			this.addEventListener(SecurityErrorEvent.SECURITY_ERROR,errorfun);
			this.load(new URLRequest(url));
		}
		private function completeFun(e:Event):void{
			if(_fun!=null)_fun(e.target.data);
			
			destroy();
		}
		
		private function removeEvent():void{
			this.removeEventListener(Event.COMPLETE,completeFun);
			this.removeEventListener(IOErrorEvent.IO_ERROR,errorfun);
			this.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,errorfun);
		}
		
		private function errorfun(e:Event):void{
			LogManager.throwError(e.type);
			destroy();
		}
		
		public function destroy():void{
			removeEvent();
			_fun=null;
			_url=null;
		}
	}
}