package com.pgnmate.common.chess.identifiers;

import java.util.Arrays;
import java.util.Optional;

/**
 * Enumeration of castling types
 * @author terry
 *
 */
public enum Castling {

	//Note SAN format is capital ascii letter 'O' and not the digit zero
	KINGSIDE("O-O"),
	QUEENSIDE("O-O-O");
	
	private final String sanText;	
	private Castling(final String sanText) { this.sanText = sanText; }
	
	/**
	 * SAN text representation for Castling
	 * <p>
	 * Note that the san text representation uses capital letter 'oh' and not the digit zero
	 * </p>
	 * @return PGN move text (SAN) representation of castling
	 */
	public String toSanText() { return this.sanText; }
	
	
	/**
	 * Converts san text to Castling
	 * <p>
	 * For a non-throwing version see {@link #tryFromSanText(String) tryFromSantText }
	 * </p>
	 * @param sanText
	 * @return Castling enum constant representing san text
	 * @throws NullPointerException if argument is <code>null</code>
	 * @throws IllegalArgumentException if not a valid san castling string 
	 */
	public static Castling fromSanText(final String sanText) {
		if(sanText == null) throw new NullPointerException();
		Optional<Castling> optional = Arrays.stream(Castling.values()).filter(value -> value.toSanText().equals(sanText)).findFirst();
		if(!optional.isPresent()) throw new IllegalArgumentException();
		return optional.get();
	}
	
	/**
	 * Converts san text to Castling
	 * @param sanText
	 * @return Castling enum constant representing san text or <code>null</code> on failure
	 */
	public static Castling tryFromSanText(final String sanText) {		
		Optional<Castling> optional = Arrays.stream(Castling.values()).filter(value -> value.toSanText().equals(sanText)).findFirst();
		return optional.isPresent() ? optional.get() : null;
	}
}
