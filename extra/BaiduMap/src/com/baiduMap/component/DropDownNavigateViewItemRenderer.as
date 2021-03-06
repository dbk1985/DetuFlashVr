package com.baiduMap.component
{
	import com.baiduMap.utils.ShineControler;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * author：啊星
	 * E-mail: 52305556@163.com
	 * 创建时间：2014-3-11 下午2:45:31
	 * 功能描述:
	 */
	public class DropDownNavigateViewItemRenderer extends Sprite
	{
		public var itemData:Object;
		
		private var text:TextField;
		
		private const defaultWidth:int = 13;
		
		public function DropDownNavigateViewItemRenderer(itemData:Object,needDrawLine:Boolean ,maxLen)
		{
			super();
			this.itemData = itemData;
			
			text = new TextField();
			text.height = 18;
			text.textColor = 0xcccccc;
			var format:TextFormat = new TextFormat(null,12);
			format.align = TextFormatAlign.CENTER;
			format.font = "宋体";
			text.defaultTextFormat = format;
			text.selectable=false;
			text.text = itemData.label;
			text.width = maxLen*int(text.defaultTextFormat.size)/1.7;
			if(text.width < defaultWidth)
				text.width = defaultWidth;
			text.mouseEnabled = false;
			text.filters=  [new GlowFilter(0x000000,1,2,2,5)];
			addChild(text);
			if(needDrawLine){
				graphics.lineStyle(1,0xcccccc,0.5);
				graphics.moveTo(0,16);
				var len:int = text.width;
				graphics.lineTo(len,16);
			}
			
			this.buttonMode = true;
			
			addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			addEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
		
		private function onRollOver(e:MouseEvent):void{
				ShineControler.setBrightness(text,0.15);
				text.textColor = 0xffffff;
		}
		
		private function onRollOut(e:MouseEvent):void{
				ShineControler.setBrightness(text,0);
				text.textColor = 0xcccccc;
		}
		
		public function destroy():void{
			removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
			removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
	}
}