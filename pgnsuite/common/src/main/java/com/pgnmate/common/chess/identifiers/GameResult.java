package com.pgnmate.common.chess.identifiers;

import java.util.Arrays;

/**
 * Enumerated chess game result type
 * 
 * @author terry
 *
 */
public enum GameResult {

	WHITE_WINS,
	BLACK_WINS,
	DRAWN,
	UNKNOWN;
	
	private static final String[] PGN_TEXT = { "1-0", "0-1", "1/2-1/2", "*"};
	
	/**
	 * Returns game result as PGN text representation (SAN)
	 * @return PGN text string (SAN)
	 */
	public String toSanText() { return PGN_TEXT[ ordinal() ]; }
	
	
	/**
	 * Converts from PGN (san) text representation
	 * <p>
	 * This implementation throws on invalid arguments. A non-throwing version is {@link #tryFromSanText(String) tryFromSanText}
	 * </p>
	 * @param san the pgn text value
	 * @return GameResult corresponding to the PGN text
	 * @throws NullPointerException if argument is <code>null</code>
	 * @throws IllegalArgumentException if not a valid san game result string
	 */
	public static GameResult fromSanText(final String san) {
		if(san == null) throw new NullPointerException();
		int index = Arrays.asList(PGN_TEXT).indexOf(san);
		if(index < 0 || index >= GameResult.values().length) throw new IllegalArgumentException();
		return (index >= 0 && index < GameResult.values().length) ? GameResult.values()[index] : null;
	}
	
	
	/**
	 * Converts from PGN (san) text representation	
	 * @param san the pgn text value
	 * @return GameResult corresponding to the PGN text version or <code>null</code> on failure
	 */
	public static GameResult tryFromSanText(final String san) {
		GameResult result = null;
		if(san != null) {
			int index = Arrays.asList(PGN_TEXT).indexOf(san);
			result =  (index >= 0 && index < GameResult.values().length) ? GameResult.values()[index] : null;
		}
		return result;
	}
}
