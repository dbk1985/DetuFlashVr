/*
 OuWei Flash3DHDView 
*/
package  com.panozona.modules.baiduMap.controller{
	
	import com.panozona.modules.baiduMap.view.CloseView;
	import com.panozona.player.module.data.property.Align;
	import com.panozona.player.module.Module;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	
	public class CloseController {
		
		private var _closeView:CloseView;
		private var _module:Module;
		
		public function CloseController(closeView:CloseView, module:Module){
			_closeView = closeView;
			_module = module;
			
			if (_closeView.baiduMapData.close.path == null) return;
			
			var imageLoader:Loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageLost, false, 0, true);
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded, false, 0, true);
			imageLoader.load(new URLRequest(_closeView.baiduMapData.close.path),new flash.system.LoaderContext(true));
		}
		
		private function imageLost(error:IOErrorEvent):void {
			error.target.removeEventListener(IOErrorEvent.IO_ERROR, imageLost);
			error.target.removeEventListener(Event.COMPLETE, imageLoaded);
			_module.printError(error.text);
		}
		
		private function imageLoaded(e:Event):void {
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, imageLost);
			e.target.removeEventListener(Event.COMPLETE, imageLoaded);
			_closeView.addChild(e.target.content)
			_closeView.addEventListener(MouseEvent.CLICK, handleMouseClick, false, 0, true);
			placeonWindow();
		}
		
		private function placeonWindow(e:Event = null):void {
			if (_closeView.baiduMapData.close.align.horizontal == Align.LEFT) {
				_closeView.x = 0;
			}else if (_closeView.baiduMapData.close.align.horizontal == Align.RIGHT) {
				_closeView.x = _closeView.baiduMapData.windowData.window.size.width - _closeView.width;
			}else { // CENTER
				_closeView.x = (_closeView.baiduMapData.windowData.window.size.width - _closeView.width) * 0.5;
			}
			if (_closeView.baiduMapData.close.align.vertical == Align.TOP){
				_closeView.y = 0;
			}else if (_closeView.baiduMapData.close.align.vertical == Align.BOTTOM) {
				_closeView.y = _closeView.baiduMapData.windowData.window.size.height - _closeView.height;
			}else { // MIDDLE
				_closeView.y = (_closeView.baiduMapData.windowData.window.size.height - _closeView.height) * 0.5;
			}
			_closeView.x += _closeView.baiduMapData.close.move.horizontal;
			_closeView.y += _closeView.baiduMapData.close.move.vertical;
		}
		
		private function handleMouseClick(e:Event):void {
			_closeView.baiduMapData.windowData.open = false;
		}
	}
}