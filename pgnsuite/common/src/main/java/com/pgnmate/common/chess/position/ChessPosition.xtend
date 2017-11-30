package com.pgnmate.common.chess.position

import com.pgnmate.common.chess.position.IChessPosition
import com.pgnmate.common.chess.identifiers.PieceColor
import com.pgnmate.common.chess.identifiers.CastlingRights
import static extension com.pgnmate.common.chess.identifiers.SquareId.*


class ChessPosition extends ChessboardMap implements IChessPosition {

	var int enPassant = -1
	var int halfMoveClock = 0
	var int fullMoveClock = 0
	var PieceColor colorToMove = PieceColor::WHITE
	var castlingRights = <CastlingRights>newArrayList(CastlingRights::BOTH, CastlingRights::BOTH)

	override getHalfMoveClock() { halfMoveClock }

	override setHalfMoveClock(int value) {
		if(value < 0) throw new IllegalArgumentException 		
		halfMoveClock = value
	}

	override getFullMoveClock() { fullMoveClock }

	override setFullMoveClock(int value) {
		if(value < 0) throw new IllegalArgumentException 
		fullMoveClock = value
	}

	override getColorToMove() { colorToMove }

	override setColorToMove(PieceColor color) {
		if(color === null) throw new NullPointerException 
		colorToMove = color
	}

	override getCastlingRights(PieceColor color) {
		castlingRights.get(color.ordinal)
	}

	override setCastlingRights(PieceColor color, CastlingRights rights) {
		if(color === null || rights === null) throw new NullPointerException
		castlingRights.set(color.ordinal, rights)
	}
	
	override getEnPassantSquare() {
		enPassant
	}
	
	override setEnPassantSquare(int square) {
		if(square == -1)
			enPassant = -1
		else{
			val rank = square.rank
			if(rank != 2 && rank != 5) throw new IllegalArgumentException
			enPassant = square
		}
	}

}
