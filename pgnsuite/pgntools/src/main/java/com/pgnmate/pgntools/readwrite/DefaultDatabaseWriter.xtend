package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgntools.readwrite.IDatabaseWriter
import com.pgnmate.pgnparser.facade.IPGNDatabase
import static extension com.pgnmate.pgnparser.facade.PGNUtils.*

/**
 * Default writer prints formatted pgn files to stdout
 */
package class DefaultDatabaseWriter implements IDatabaseWriter {
		
		
	/**
	 * Write database to stdout
	 * @param db Database to write
	 */
	override write(IPGNDatabase db) {
		println(db.decompile)					
	}
	
}