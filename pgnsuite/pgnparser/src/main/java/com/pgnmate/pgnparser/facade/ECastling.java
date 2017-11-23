package com.pgnmate.pgnparser.facade;

/**
 * Enumeration representing a castling move
 * @author terry
 */
public enum ECastling {

	//Note SAN format is capital ascii letter 'O' and not the digit zero
	KINGSIDE("O-O"),
	QUEENSIDE("O-O-O");
	
	private final String sanText;	
	private ECastling(final String sanText) { this.sanText = sanText; }
	
	/**
	 * 
	 * @return PGN move text (SAN) representation of castling
	 */
	public String getSantText() { return this.sanText; }
}
