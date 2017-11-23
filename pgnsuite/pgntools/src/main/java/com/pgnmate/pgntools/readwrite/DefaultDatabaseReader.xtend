package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgntools.readwrite.IDatabaseReader
import com.pgnmate.pgnparser.facade.IPGNDatabaseParser
import com.google.inject.Inject
import com.google.inject.Provider
import com.pgnmate.pgnparser.facade.IPGNDatabase
import org.apache.log4j.Logger

/**
 * Default pgn database reader. Assumes plain ascii text input file
 */
package class DefaultDatabaseReader implements IDatabaseReader {
	
	static val logger = Logger::getLogger(DefaultDatabaseReader)
	
	
	@Inject Provider<IPGNDatabaseParser> parserProvider
	
	
	/**
	 * Read pgn database from ascii file
	 * @param filename Input file name of pgn database
	 * @return parsed pgn file or <code>null</code> on failure
	 */
	override read(Object filename) {
				
		var IPGNDatabase db = null
		
		if(filename instanceof String){			
			val parser = parserProvider.get
			db = parser.parseFromFileName(filename)					
		}
		else{
			val msg = '''argument was "«filename»" expected file name'''
			logger.error(msg)
		}
		db
	}	
}