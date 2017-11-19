package com.pgnmate.pgn.facade

import java.util.Collection


/**
 * PGN database interface
 */
interface IPGNDatabase extends IPGNNode {
	
	/**
	 * @return All games in the database
	 * @Note That the returned objects may be proxies depending on the implementation
	 */
	def Collection<IPGNGame> getGames()

}