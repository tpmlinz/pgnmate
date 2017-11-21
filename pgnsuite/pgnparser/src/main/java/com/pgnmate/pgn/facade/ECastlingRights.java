package com.pgnmate.pgn.facade;

public enum ECastlingRights {
	
	KINGSIDE("K"),
	QUEENSIDE("Q"),
	BOTH("KQ"),
	NEITHER("-");
	
	private final String fen; 
	private ECastlingRights(final String fen) { this.fen = fen; }
	
	public String getFEN() {	
		return fen.toUpperCase();
	}
}
