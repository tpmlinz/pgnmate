package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgntools.readwrite.IDatabaseReader
import com.pgnmate.pgn.facade.IPGNDatabaseParser
import com.google.inject.Inject
import com.google.inject.Provider
import com.pgnmate.pgn.facade.IPGNDatabase

package class DefaultDatabaseReader implements IDatabaseReader {
	
	@Inject Provider<IPGNDatabaseParser> parserProvider
	
	
	override read(Object source) {
				
		var IPGNDatabase db = null
		
		if(source instanceof String){			
			val parser = parserProvider.get
			db = parser.parseFromFileName(source)					
		}		
		db
	}	
}