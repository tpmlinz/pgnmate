package com.pgnmate.common.chess.identifiers;

import java.util.Arrays;
import java.util.Optional;

/**
 * Enumeration of PGN move suffixes
 * 
 * @author terry
 *
 */
public enum PGNMoveSuffix {

	GOOD("!"),
	BRILLIANT("!!"),
	MISTAKE("?"),
	BLUNDER("??"),
	INTERESTING("!?"),
	DUBIOUS("?!");
	
	private final String text;
	private PGNMoveSuffix(final String name) { this.text = name; }
		
	
	/**
	 * Returns a PGN version (san text) of the move suffix
	 * @return SAN string representation
	 */
	public String toSanText() { return text; }
	
	
	/**
	 * Converts PGN san string to PGNMoveSuffix
	 * <p>
	 * This method throws, for a non-throwing version see {@link #tryFromSanText(String) tryFromSanText }
	 * </p>
	 * @param str to convert to suffix
	 * @return value of type ESuffix that string represents or <code>null</code> if string is not a valid suffix
	 * @throws NullPointerException if argument is <code>null</code>
	 * @throws IllegalArgumentException if not a valid san move suffix string 
	 */
	static public PGNMoveSuffix fromSanText(final String san) {
		if(san == null) throw new NullPointerException();
		Optional<PGNMoveSuffix> optional = Arrays.stream(PGNMoveSuffix.values()).filter(suffix -> suffix.toSanText().equals(san)).findFirst();
		if(!optional.isPresent()) throw new IllegalArgumentException();
		return optional.get();
	}
	
	/**
	 * Converts PGN san string to PGNMoveSuffix
	 * @param str to convert to suffix
	 * @return value of type PGNMoveSuffix that string represents or <code>null</code> if string is not a valid suffix  
	 */
	static public PGNMoveSuffix tryFromSanText(final String san) {
		Optional<PGNMoveSuffix> optional = Arrays.stream(PGNMoveSuffix.values()).filter(suffix -> suffix.toSanText().equals(san)).findFirst();
		return optional.isPresent() ? optional.get() : null;
	}
}
