package com.pgnmate.common.chess.identifiers;

public enum PieceColor {

	BLACK,
	WHITE;
	
	public String toFenText() { return (this == WHITE) ? "w" : "b"; }
	public char toFenChar() { return (this == WHITE) ? 'w' : 'b'; }
	
	
	/**
	 * Returns PieceColor from FEN string
	 * @param fenText FEN text representation of color ('w' | 'b'). May not be <code>null</code>
	 * @return Color constant for text. Never <code>null</code>
	 * @throws NullPointerException on <code>null</code> fenText
	 * @throws IllegalArgumentException on invalid fenText
	 */
	public static PieceColor fromFenText(String fenText) {
		
		if(fenText == null) throw new NullPointerException();
		
		PieceColor pieceColor = null;
		
		if(fenText.equals("w"))
			pieceColor = WHITE;		
		else if(fenText.equals("b"))
			pieceColor = BLACK;
		else
			throw new IllegalArgumentException();
		
		return pieceColor;
	}
	
	
	/**
	 * Return PieceColor from FEN text
	 * @param fenText FEN text representation of color ('w' | 'b')
	 * @return Color constant for text or <code>null</code> on failure
	 */
	public static PieceColor tryFromFenText(String fenText) {
		PieceColor pieceColor = null;
		
		if(fenText != null) {
			if(fenText.equals("w"))
				pieceColor = WHITE;		
			else if(fenText.equals("b"))
				pieceColor = BLACK;
		}		
		return pieceColor;
	}
	
	
	/**
	 * Return PieceColor from FEN char
	 * @param fenChar FEN character representation of color ('w' | 'b')
	 * @return Color constant for char. Never <code>null</code>
 	 * @throws IllegalArgumentException on invalid FEN char
	 */
	public static PieceColor fromFenChar(char fenChar) {
		PieceColor pieceColor = null;
		
		if(fenChar == 'w')
			pieceColor = WHITE;
		else if(fenChar == 'b')
			pieceColor = BLACK;
		else
			throw new IllegalArgumentException();
		
		return pieceColor;
	}
	
	/**
	 * Return PieceColor from FEN char
	 * @param fenChar FEN character representation of color ('w' | 'b')
	 * @return Color constant for char or <code>null</code> on failure
	 */
	public static PieceColor tryFromFenChar(char fenChar) {
		
		PieceColor pieceColor = null;
		
		if(fenChar == 'w')
			pieceColor = WHITE;
		else if(fenChar == 'b')
			pieceColor = BLACK;	
		
		return pieceColor;
	}
}
