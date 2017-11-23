package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgnparser.facade.IPGNDatabase


/**
 * Database reader interface
 */
interface IDatabaseReader {
	
	/**
	 * Read pgn source
	 * @param source of pgn data
	 * @return parsed pgn database or null on failure
	 */	
	def IPGNDatabase read(Object source)
}