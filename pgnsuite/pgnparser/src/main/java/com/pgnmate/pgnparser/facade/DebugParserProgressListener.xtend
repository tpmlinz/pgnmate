package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.google.inject.Singleton

@Singleton
class DebugParserProgressListener implements IParserProgressListener {
	
	override onProgress(IParserProgressEvent progress) {
		switch(progress.eventID){
			case IParserProgressEvent::EV_START : println('''START: size =  «progress.size», current = «progress.current»''')
			case IParserProgressEvent::EV_UPDATE : println('''UPDATE: size =  «progress.size», current = «progress.current»''')
			case IParserProgressEvent::EV_DONE : println('''DONE: size =  «progress.size», current = «progress.current»''')			
		}
	}	
}
