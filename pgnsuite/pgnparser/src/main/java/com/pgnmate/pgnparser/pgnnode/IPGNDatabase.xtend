package com.pgnmate.pgnparser.pgnnode

import java.util.Collection


/**
 * PGN database interface
 */
interface IPGNDatabase extends IPGNNode {
	
	/**
	 * Returns games in the database
	 * 
	 * @return All games in the database
	 */
	def Collection<IPGNGame> getGames()

}