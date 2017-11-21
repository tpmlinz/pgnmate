package com.pgnmate.pgn.facade;

import java.util.Arrays;

/**
 * Enumeration type representing the suffix values of a PGN move (SAN move)
 * 
 * @author terry
 */
public enum ESuffix {
	
	GOOD("!"),
	BRILLIANT("!!"),
	MISTAKE("?"),
	BLUNDER("??"),
	INTERESTING("!?"),
	DUBIOUS("?!");
	
	private final String text;

	private ESuffix(final String name) { this.text = name; }
	
	
	public String getText() { return text; }
	
	
	@Override
	public String toString() { return this.text; } //FIXME - remove this use getText()
	
	/**
	 * 
	 * @param str to convert to suffix
	 * @return value of type ESuffix that string represents or <code>null</code> if string is not a valid suffix  
	 */
	static public ESuffix fromString(final String str) {
		return Arrays.stream(ESuffix.values()).filter(suffix -> suffix.getText().equals(str)).findFirst().get();				
	}
}
