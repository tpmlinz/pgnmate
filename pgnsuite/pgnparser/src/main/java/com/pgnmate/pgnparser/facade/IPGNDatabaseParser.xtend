package com.pgnmate.pgnparser.facade

import org.antlr.v4.runtime.CharStream

/**
 * PGN Database parser interface
 */
interface IPGNDatabaseParser{
	
	/**
	 * Parse PGN database
	 * @param charStream to read database from
	 * @return Parsed PGN database. May be <code>null</code> on failure
	 */
	def IPGNDatabase parse(CharStream charStream)
	
	/**
	 * Convenience method automatically creates CharStream and calls parse
	 * @param fileName to parse
	 * @return Parsed PGN database. May be <code>null</code> on failure
	 * @Note The created CharStream assumes US-ASCII charset as per PGN standard
	 */
	def IPGNDatabase parseFromFileName(String fileName)
	
	def void addProgressListener(IParserProgressListener listener)	
	def void removeProgressLsitener(IParserProgressListener listener)
		
}