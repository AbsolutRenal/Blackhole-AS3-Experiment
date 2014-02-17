/**
 *
 * Blackhole/Repulsor
 *
 * https://github.com/AbsolutRenal
 *
 * Copyright (c) 2012 AbsolutRenal (Renaud Cousin). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
**/

package com.utils.loaders {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;


	/**
	 * @author renaud.cousin
	 */
	public class LoaderImg extends AbstractLoader{
		
		private var _data:Bitmap;
		
		private var loader:Loader;
		
		public function LoaderImg(url:String){
			super(url);
		}
		
		
		//----------------------------------------------------------------------
		// E V E N T S
		//----------------------------------------------------------------------

		override protected function onLoadError(event:IOErrorEvent):void {
			removeListener(loader.contentLoaderInfo);
			loader = null;
			
			super.onLoadError(event);
		}

		override protected function onLoadComplete(event:Event):void {
			_data = loader.content as Bitmap;
			_data.smoothing = true;
			_data.cacheAsBitmap = true;
			
			removeListener(loader.contentLoaderInfo);
			
			super.onLoadComplete(event);
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		override public function load():void{
			loader = new Loader();
			addListener(loader.contentLoaderInfo);
			loader.load(new URLRequest(url));
		}
		
		override public function stopLoading():void{
			if(loader != null)
				loader.close();
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R / S E T T E R
		//----------------------------------------------------------------------

		public function get data():Bitmap {
			return _data;
		}
	}
}
