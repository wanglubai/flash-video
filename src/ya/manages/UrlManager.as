package ya.manages
{
	
	/**
	 * 网址链接管理器 
	 * @author wangshuang
	 * 
	 */
	public class UrlManager
	{
		private static var _instance:UrlManager;
		public static function get instance():UrlManager{
			if(_instance==null){
				_instance=new UrlManager();
			}
			return _instance;
		}
		
		public function getStreamUrl(cid:String):String{
			return '';
		}
		public function getPlayerUrl():String{
			
			return "";

		}
		
		public function UrlManager(){
			ErrorManager.singleError(_instance);
		}
		
		
		public function getResUrl(url:String):String{
			return 'res/'+url;
		}
		
		public function getBtnResUrl(url:String):String{
			return 'res/btn/'+url;
		}
	}
}
