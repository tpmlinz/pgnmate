package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.ESuffix


interface IPGNMove extends IPGNNode {
		
	/**
	 * @return SAN move suffix
	 */
	def ESuffix getSuffix()
	
	/**
	 * @return Castling type or <code>null</code> if a non-castling move
	 */
	def ECastling getCastling()
	
	/**
	 * Set new suffix value
	 * @param suffix value to set
	 */
	def void setSuffix(ESuffix suffix)
	
	/**
	 * Set new suffix value from String
	 * @param suffix value as String
	 * @Note If the String argument is not convertible to a suffix value the
	 * behaviour is not defined. Some implementations may through an exception 
	 * or others may set the suffix to <code>null</code>. Most will probably set
	 * the value of that returned by {@ref ESuffix} ESuffix which is null. Whether a String
	 * is convertible to/from an ESuffix type can be checked using {@ref ESuffix} ESuffix
	 * enumeration type members.
	 */
	def void setSuffix(String suffix)
	
	/**
	 * Remove ESuffix value. Subsequent calls to getSuffix will return <code>null</code>
	 */
	def void removeSuffix()

	/**
	 * @return true if move is with check and false otherwise
	 */
	def boolean isCheck()
		
	/**
	 * @return true if move delivers check and false otherwise
	 */
	def boolean isMate()
	
	/**
	 * @return true if this is a capturing move and false otherwise
	 */
	def boolean isCapture()
	
	/**
	 * @return true if move is a castling move and false otherwise
	 */
	def boolean isCastling()
	
	/**
	 * @return the move indicator or -1 if there no move indicator present in PGN
	 */
	def int getMoveInicator()
	
	/**
	 * Set move indicator value
	 * @param value for move indicator
	 */
	def void setMoveInicator(int value)
	
	/**
	 * Remove move indicator if present
	 */
	def void clearMoveInicator()
	
	/**
	 * @return SAN text of this move
	 */
	def String getSAN()
	
	/**
	 * @param value for SAN text
	 */
	def void setSAN(String value)	
}
