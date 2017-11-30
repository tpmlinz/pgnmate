package com.pgnmate.common.chess.identifiers;

import java.util.Arrays;
import java.util.Optional;

/**
 * Chess piece enumerated constants representing the twelve standard 
 * chess pieces from classical chess.
 * 
 * @author terry
 *
 */
public enum ChessPiece {

	WPAWN('P'),
	WROOK('R'),
	WKNIGHT('N'),
	WBISHOP('B'),
	WQUEEN('Q'),
	WKING('K'),
	BPAWN('p'),
	BROOK('r'),
	BKNIGHT('n'),
	BBISHOP('b'),
	BQUEEN('q'),
	BKING('k');
	
	private char fenChar;
	
	private ChessPiece(char fenChar) { this.fenChar = fenChar; }
	
	
	/**
	 * Returns fen character for piece
	 * @return fen text representation of piece. Never <code>null</code>
	 */
	public char toFenChar() {
		return fenChar;
	}
	
	/**
	 * Returns fen text (character as string) for piece
	 * @return fen text representation of piece. Never<code>null</code>
	 */
	public String toFenText() { 
		return Character.toString(fenChar); 
	}
	
	
	/**
	 * Returns piece represented by fen text
	 * @param ch fen char representation of piece
	 * @return piece represtned by fen char. Never <code>null</code>
	 * @throws IllegalArgumentException on invalid fen char
	 */
	static public ChessPiece fromFenChar(char ch) {
		Optional<ChessPiece> optional = Arrays.stream(ChessPiece.values()).filter(value -> value.toFenChar() == ch).findFirst();
		if(!optional.isPresent()) throw new IllegalArgumentException();
		return optional.get();

	}
	
	/**
	 * Returns piece represented by fen char
	 * @param ch char representing piece
	 * @return Piece for char or <code>null</code> on failure
	 */
	static public ChessPiece tryFromFenChar(char ch) {
		Optional<ChessPiece> optional = Arrays.stream(ChessPiece.values()).filter(value -> value.toFenChar() == ch).findFirst();
		return optional.isPresent() ? optional.get() : null;
	}
	
	/**
	 * 
	 * @param fen piece represented by fen text 
	 * @return piece represented by fen text. Never <code>null</code>
	 * @throws NullPointerException if argument is null
	 * @throws IllegalArgumentException when argument is not valid fen text for a piece
	 */
	static public ChessPiece fromFenText(String fen) {
		if(fen == null) throw new NullPointerException();
		if(fen.isEmpty()) throw new IllegalArgumentException();
		return fromFenChar(fen.charAt(0));
	}
	
	/**
	 * Returns piece represented by fen text 
	 * @param piece or null on failure
	 * @return
	 */
	static public ChessPiece tryFromFenText(String fen) {
		ChessPiece result = null;
		if(fen != null && !fen.isEmpty()) {
			result = tryFromFenChar(fen.charAt(0));
		}
		return result;
	}
	
	
	/**
	 * Returns piece color
	 * @return color of piece. Never <code>null</code>
	 */
	public PieceColor getColor() {
		return (ordinal() < 6) ? PieceColor.WHITE : PieceColor.BLACK;
	}
	
	/**
	 * Returns a chess piece of opposite color
	 * @return the same piece but of opposite color. Never <code>null</code>
	 */
	public ChessPiece getFlippedColor() { return values()[(ordinal() + 6) % 12]; } 
	
	public boolean isBlack() { return getColor() == PieceColor.BLACK; }
	public boolean isWhite() { return !isBlack(); }
	
}


