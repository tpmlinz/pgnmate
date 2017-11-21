package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgntools.readwrite.IDatabaseWriter
import com.pgnmate.pgn.facade.IPGNDatabase
import static extension com.pgnmate.pgn.facade.PGNUtils.*


class DefaultDatabaseWriter implements IDatabaseWriter {
		
	override write(IPGNDatabase db) {
		println(db.decompile)					
	}
	
}