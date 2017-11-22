package com.pgnmate.pgntools.readwrite

import com.google.inject.Inject
import com.google.inject.Provider
import java.util.function.Supplier
import org.apache.log4j.Logger

package class WriterFactory implements IWriterFactory {
	
	static val logger = Logger::getLogger(WriterFactory)	
	
	@Inject Provider<DefaultDatabaseWriter> defaultDatabaseWriter
	
	val map = <AbstractDatabaseFactoryKey, Supplier<IDatabaseWriter>>newHashMap
	
	new(){
		map.put(new DatabaseFactoryKey(null, null), [defaultDatabaseWriter.get])
		map.put(new DatabaseFactoryKey(null, "US-ASCII"), [defaultDatabaseWriter.get])				
	}
		
	override get(AbstractDatabaseFactoryKey key) {
		if(key === null){
			if(logger.debugEnabled){ logger.debug('null key using default writer') }			
			defaultDatabaseWriter.get
		}
		else{
			val writer = map.get(key)?.get
			if(writer === null && logger.debugEnabled){ logger.debug('''failed to find writer for key «key»''') }
			writer			
		}
	}	
	
	override add(AbstractDatabaseFactoryKey key, Supplier<IDatabaseWriter> factory) { 
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