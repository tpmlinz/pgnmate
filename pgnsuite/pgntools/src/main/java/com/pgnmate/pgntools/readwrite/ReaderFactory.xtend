package com.pgnmate.pgntools.readwrite

import com.google.inject.Inject
import com.google.inject.Provider
import java.util.function.Supplier
import org.apache.log4j.Logger


/**
 * Reader factory implementation
 */
package class ReaderFactory implements IReaderFactory {
	
	static val logger = Logger::getLogger(ReaderFactory)	
	
	@Inject Provider<DefaultDatabaseReader> defaultDatabaseReader
	
	val map = <AbstractDatabaseFactoryKey, Supplier<IDatabaseReader>>newHashMap
	
	new(){												
		map.put(new DatabaseFactoryKey(null, null), [defaultDatabaseReader.get])		
		map.put(new DatabaseFactoryKey(null, "US-ASCII"), [defaultDatabaseReader.get])		
		//map.put(new DatabaseFactoryKey("", null), [defaultDatabaseReader.get])		
		//map.put(new DatabaseFactoryKey("", "US_ASCII"), [defaultDatabaseReader.get])
		
	}
		
	override get(AbstractDatabaseFactoryKey key) {
				
		if(key === null){
			if(logger.debugEnabled){ logger.debug('null key using default reader') }
			defaultDatabaseReader.get
		} 
		else{
			val reader = map.get(key)?.get
			if(reader === null && logger.debugEnabled){ logger.debug('''failed to find reasder for key «key»''') }
			reader			
		}
	}	
	override add(AbstractDatabaseFactoryKey key, Supplier<IDatabaseReader> factory) { 
		val replacedValue = map.put(key, factory)
		if(logger.debugEnabled && replacedValue !== null){
			logger.debug('''replaced existing factory method for key «key»''')
		}
	}	
	override remove(AbstractDatabaseFactoryKey key) { 
		val oldValue = map.remove(key)
		if(oldValue !== null ){ logger.warn('''value for key «key» did not exit in map''') }
	}
	
}