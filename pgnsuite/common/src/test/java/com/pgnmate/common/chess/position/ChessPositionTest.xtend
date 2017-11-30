package com.pgnmate.common.chess.position

import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*
//import static extension com.pgnmate.common.chess.identifiers.SquareId.*
import com.pgnmate.common.chess.identifiers.SquareId
import com.pgnmate.common.chess.identifiers.PieceColor

@DisplayName("Chess Position Test")
class ChessPositionTest extends AbstractCommonTest{

	@Test
	package def void enPassantTest(){
		
		val position = new ChessPosition		
		val thirdRank = (0 .. 7).map[SquareId::getSquareId(2, it)]
		val sixthRank = (0 .. 7).map[SquareId::getSquareId(5, it)]
		
		for(i : thirdRank){
			position.enPassantSquare = i
			i.assertEquals(position.enPassantSquare)
		}
		for(i : sixthRank){
			position.enPassantSquare = i
			i.assertEquals(position.enPassantSquare)			
		}
		
		position.enPassantSquare = -1
		(-1).assertEquals(position.enPassantSquare)
	}
	
	@Test
	package def void invalidEnPassantTest(){
		val position = new ChessPosition
		for(f : 0 .. 7){
			IllegalArgumentException.assertThrows([position.enPassantSquare = SquareId::getSquareId(0, f)])
			IllegalArgumentException.assertThrows([position.enPassantSquare = SquareId::getSquareId(1, f)])
			IllegalArgumentException.assertThrows([position.enPassantSquare = SquareId::getSquareId(3, f)])
			IllegalArgumentException.assertThrows([position.enPassantSquare = SquareId::getSquareId(4, f)])
			IllegalArgumentException.assertThrows([position.enPassantSquare = SquareId::getSquareId(6, f)])
			IllegalArgumentException.assertThrows([position.enPassantSquare = SquareId::getSquareId(7, f)])		
		}
		
		IllegalArgumentException.assertThrows([position.enPassantSquare = -10])
		IllegalArgumentException.assertThrows([position.enPassantSquare = 64])
		IllegalArgumentException.assertThrows([position.enPassantSquare = 100])		
	}
		
	@Test
	package def void halfMoveClockTest(){
		val position = new ChessPosition		
		for( i : 0 .. 50){
			position.halfMoveClock = i
			i.assertEquals(position.halfMoveClock)	
		}
		IllegalArgumentException.assertThrows([position.halfMoveClock = -1])
		IllegalArgumentException.assertThrows([position.halfMoveClock = -100])				
	}
	
	@Test
	package def void fullMoveClockTest(){
		val position = new ChessPosition		
		for( i : 0 .. 50){
			position.fullMoveClock = i
			i.assertEquals(position.fullMoveClock)	
		}
		IllegalArgumentException.assertThrows([position.fullMoveClock = -1])
		IllegalArgumentException.assertThrows([position.fullMoveClock = -100])	
	}
	
	
	@Test
	package def void colorToMoveTest(){
		val position = new ChessPosition		
		position.colorToMove = PieceColor::WHITE
		PieceColor::WHITE.assertEquals(position.colorToMove)
		position.colorToMove = PieceColor::BLACK
		PieceColor::BLACK.assertEquals(position.colorToMove)
		NullPointerException.assertThrows([position.colorToMove = null])
	}
}

