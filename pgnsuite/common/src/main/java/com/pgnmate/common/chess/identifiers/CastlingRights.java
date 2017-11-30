package com.pgnmate.common.chess.identifiers;

import java.util.Arrays;
import java.util.Optional;

/**
 * Enumerated castling rights
 * 
 * @author terry
 *
 */
public enum CastlingRights {

	KINGSIDE("K"),
	QUEENSIDE("Q"),
	BOTH("KQ"),
	NEITHER("-");
	
	private final String fen; 
	private CastlingRights(final String fen) { this.fen = fen; }
	
	/**
	 * Returns text representation in FEN notation
	 * <p>
	 * Note that only FEN text for white player is returned, i.e. uppercase. For
	 * black player the returned string must be converted to lowercase
	 * </p>
	 * @return FEN string representation
	 */
	public String toFenText() {	
		return fen;
	}
	
	
	/**
	 * Converts FEN text representation to enum constant
	 * <p>
	 * Note that player colour is ignored so 'K' = 'k' and 'Q'='q'
	 * </p>
	 * @param fenText text in FEN notation
	 * @return constant enum for FEN text
	 * @throws NullPointerException if argument is <code>null</code>
	 * @throws IllegalArgumentException if not a valid FEN string 
	 */
	static public CastlingRights fromFenText(final String fenText) {
	
		if(fenText == null) throw new NullPointerException();

		Optional<CastlingRights> optional = Arrays.stream(CastlingRights.values())
				.filter(value -> value.toFenText().equals(fenText.toUpperCase())).findFirst();
		if(!optional.isPresent()) throw new IllegalArgumentException();
		return optional.get();
	}
	
	
	/**
	 * Converts FEN text representation to enum constant
	 * @param fenText text in FEN notation
	 * @return constant enum for FEN text or <code>null</code> on failure
	 */
	static public CastlingRights tryFromFenText(final String fenText) {
		
		CastlingRights result = null;
		if(fenText != null) {
			Optional<CastlingRights> optional = Arrays.stream(CastlingRights.values()).filter(value -> value.toFenText().equals(fenText.toUpperCase())).findFirst();
			result = optional.isPresent() ? optional.get() : null;
		}
		return result;
	}
}
