package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgnparser.facade.IPGNDatabase


/**
 * PGN database writer interface
 */
interface IDatabaseWriter {
	
	/**
	 * Write DB to target
	 * @param db to write from
	 */	
	def void write(IPGNDatabase db)
}