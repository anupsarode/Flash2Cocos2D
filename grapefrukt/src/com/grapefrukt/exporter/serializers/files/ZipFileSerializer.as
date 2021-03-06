/*
Copyright 2011 Martin Jonasson, grapefrukt games. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY grapefrukt games "AS IS" AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL grapefrukt games OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of grapefrukt games.
*/

package com.grapefrukt.exporter.serializers.files {
	import deng.fzip.FZip;
	import flash.events.Event;
	import flash.system.fscommand;
	
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Martin Jonasson, m@grapefrukt.com
	 */
	public class ZipFileSerializer implements IFileSerializer{
		
		protected var _zip:FZip;
		private var _exit_after_save:Boolean;
		
		public function ZipFileSerializer(exitAfterSave:Boolean = false) {
			_exit_after_save = exitAfterSave;
			_zip = new FZip;
		}
		
		public function serialize(filename:String, file:ByteArray):void{
			_zip.addFile(filename, file, false);
		}
		
		public function output():void{
			var fr:FileReference = new FileReference;
			var zip:ByteArray = new ByteArray;
			_zip.serialize(zip);
			if (_exit_after_save) fr.addEventListener(Event.COMPLETE, handleComplete);
			fr.save(zip, "data.zip");
		}
		
		private function handleComplete(e:Event):void {
			fscommand("quit");
		}
		
	}

}