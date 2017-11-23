package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.pgnmate.pgnparser.facade.IParserProgressEvent
import org.apache.log4j.Logger

package class LoggingParserProgressListener implements IParserProgressListener {
	
	static val logger = Logger::getLogger(LoggingParserProgressListener)		
		
	override onProgress(IParserProgressEvent progress) {
		switch(progress.eventID){
			case IParserProgressEvent::EV_START : logger.debug('''START: size =  «progress.size», current = «progress.current»''')
			case IParserProgressEvent::EV_UPDATE : logger.debug('''UPDATE: size =  «progress.size», current = «progress.current»''')
			case IParserProgressEvent::EV_DONE : logger.debug('''DONE: size =  «progress.size», current = «progress.current»''')			
		}
	}	
	
	
}