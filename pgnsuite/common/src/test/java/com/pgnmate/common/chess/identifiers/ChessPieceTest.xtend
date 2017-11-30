package com.pgnmate.common.chess.identifiers

import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*

@DisplayName("ChessPiece Test")
class ChessPieceTest extends AbstractCommonTest{
	

	@Test
	package def toFenCharTest(){
		
		'P'.xChar.assertEquals(ChessPiece::WPAWN.toFenChar)
		'R'.xChar.assertEquals(ChessPiece::WROOK.toFenChar)
		'N'.xChar.assertEquals(ChessPiece::WKNIGHT.toFenChar)
		'B'.xChar.assertEquals(ChessPiece::WBISHOP.toFenChar)
		'Q'.xChar.assertEquals(ChessPiece::WQUEEN.toFenChar)
		'K'.xChar.assertEquals(ChessPiece::WKING.toFenChar)
		
		'p'.xChar.assertEquals(ChessPiece::BPAWN.toFenChar)
		'r'.xChar.assertEquals(ChessPiece::BROOK.toFenChar)
		'n'.xChar.assertEquals(ChessPiece::BKNIGHT.toFenChar)
		'b'.xChar.assertEquals(ChessPiece::BBISHOP.toFenChar)
		'q'.xChar.assertEquals(ChessPiece::BQUEEN.toFenChar)
		'k'.xChar.assertEquals(ChessPiece::BKING.toFenChar)
				
	}
	
	@Test
	package def void toFentTextTest(){
			
		'P'.assertEquals(ChessPiece::WPAWN.toFenText)
		'R'.assertEquals(ChessPiece::WROOK.toFenText)
		'N'.assertEquals(ChessPiece::WKNIGHT.toFenText)
		'B'.assertEquals(ChessPiece::WBISHOP.toFenText)
		'Q'.assertEquals(ChessPiece::WQUEEN.toFenText)
		'K'.assertEquals(ChessPiece::WKING.toFenText)
		
		'p'.assertEquals(ChessPiece::BPAWN.toFenText)
		'r'.assertEquals(ChessPiece::BROOK.toFenText)
		'n'.assertEquals(ChessPiece::BKNIGHT.toFenText)
		'b'.assertEquals(ChessPiece::BBISHOP.toFenText)
		'q'.assertEquals(ChessPiece::BQUEEN.toFenText)
		'k'.assertEquals(ChessPiece::BKING.toFenText)
	}
	
	@Test
	package def void colorTest(){
		PieceColor::WHITE.assertEquals(ChessPiece::WPAWN.color)
		PieceColor::WHITE.assertEquals(ChessPiece::WROOK.color)
		PieceColor::WHITE.assertEquals(ChessPiece::WKNIGHT.color)
		PieceColor::WHITE.assertEquals(ChessPiece::WBISHOP.color)
		PieceColor::WHITE.assertEquals(ChessPiece::WQUEEN.color)
		PieceColor::WHITE.assertEquals(ChessPiece::WKING.color)

		PieceColor::BLACK.assertEquals(ChessPiece::BPAWN.color)
		PieceColor::BLACK.assertEquals(ChessPiece::BPAWN.color)
		PieceColor::BLACK.assertEquals(ChessPiece::BPAWN.color)
		PieceColor::BLACK.assertEquals(ChessPiece::BPAWN.color)
		PieceColor::BLACK.assertEquals(ChessPiece::BPAWN.color)
		PieceColor::BLACK.assertEquals(ChessPiece::BPAWN.color)
		
	}
	
	@Test
	package def colorIsTest(){
		ChessPiece::WPAWN.white.assertTrue
		ChessPiece::WROOK.white.assertTrue
		ChessPiece::WKNIGHT.white.assertTrue
		ChessPiece::WBISHOP.white.assertTrue
		ChessPiece::WQUEEN.white.assertTrue
		ChessPiece::WKING.white.assertTrue
		
		ChessPiece::BPAWN.black.assertTrue
		ChessPiece::BROOK.black.assertTrue
		ChessPiece::BKNIGHT.black.assertTrue
		ChessPiece::BBISHOP.black.assertTrue	
		ChessPiece::BQUEEN.black.assertTrue
		ChessPiece::BKING.black.assertTrue
		
	}
	
	@Test
	package def fromFenCharTest(){
		ChessPiece::WPAWN.assertEquals(ChessPiece::fromFenChar('P'.xChar))
		ChessPiece::WROOK.assertEquals(ChessPiece::fromFenChar('R'.xChar))
		ChessPiece::WKNIGHT.assertEquals(ChessPiece::fromFenChar('N'.xChar))
		ChessPiece::WBISHOP.assertEquals(ChessPiece::fromFenChar('B'.xChar))
		ChessPiece::WQUEEN.assertEquals(ChessPiece::fromFenChar('Q'.xChar))
		ChessPiece::WKING.assertEquals(ChessPiece::fromFenChar('K'.xChar))

		ChessPiece::BPAWN.assertEquals(ChessPiece::fromFenChar('p'.xChar))
		ChessPiece::BROOK.assertEquals(ChessPiece::fromFenChar('r'.xChar))
		ChessPiece::BKNIGHT.assertEquals(ChessPiece::fromFenChar('n'.xChar))
		ChessPiece::BBISHOP.assertEquals(ChessPiece::fromFenChar('b'.xChar))
		ChessPiece::BQUEEN.assertEquals(ChessPiece::fromFenChar('q'.xChar))
		ChessPiece::BKING.assertEquals(ChessPiece::fromFenChar('k'.xChar))
		
	}
	
	@Test
	package def tryFromFenCharTest(){
		ChessPiece::WPAWN.assertEquals(ChessPiece::tryFromFenChar('P'.xChar))
		ChessPiece::WROOK.assertEquals(ChessPiece::tryFromFenChar('R'.xChar))
		ChessPiece::WKNIGHT.assertEquals(ChessPiece::tryFromFenChar('N'.xChar))
		ChessPiece::WBISHOP.assertEquals(ChessPiece::tryFromFenChar('B'.xChar))
		ChessPiece::WQUEEN.assertEquals(ChessPiece::tryFromFenChar('Q'.xChar))
		ChessPiece::WKING.assertEquals(ChessPiece::tryFromFenChar('K'.xChar))

		ChessPiece::BPAWN.assertEquals(ChessPiece::tryFromFenChar('p'.xChar))
		ChessPiece::BROOK.assertEquals(ChessPiece::tryFromFenChar('r'.xChar))
		ChessPiece::BKNIGHT.assertEquals(ChessPiece::tryFromFenChar('n'.xChar))
		ChessPiece::BBISHOP.assertEquals(ChessPiece::tryFromFenChar('b'.xChar))
		ChessPiece::BQUEEN.assertEquals(ChessPiece::tryFromFenChar('q'.xChar))
		ChessPiece::BKING.assertEquals(ChessPiece::tryFromFenChar('k'.xChar))
	}
	
	@Test
	package def fromFenTextTest(){
		ChessPiece::WPAWN.assertEquals(ChessPiece::fromFenText('P'))
		ChessPiece::WROOK.assertEquals(ChessPiece::fromFenText('R'))
		ChessPiece::WKNIGHT.assertEquals(ChessPiece::fromFenText('N'))
		ChessPiece::WBISHOP.assertEquals(ChessPiece::fromFenText('B'))
		ChessPiece::WQUEEN.assertEquals(ChessPiece::fromFenText('Q'))
		ChessPiece::WKING.assertEquals(ChessPiece::fromFenText('K'))

		ChessPiece::BPAWN.assertEquals(ChessPiece::fromFenText('p'))
		ChessPiece::BROOK.assertEquals(ChessPiece::fromFenText('r'))
		ChessPiece::BKNIGHT.assertEquals(ChessPiece::fromFenText('n'))
		ChessPiece::BBISHOP.assertEquals(ChessPiece::fromFenText('b'))
		ChessPiece::BQUEEN.assertEquals(ChessPiece::fromFenText('q'))
		ChessPiece::BKING.assertEquals(ChessPiece::fromFenText('k'))
	}
	
	@Test
	package def tryFromFenTextTest(){
		ChessPiece::WPAWN.assertEquals(ChessPiece::tryFromFenText('P'))
		ChessPiece::WROOK.assertEquals(ChessPiece::tryFromFenText('R'))
		ChessPiece::WKNIGHT.assertEquals(ChessPiece::tryFromFenText('N'))
		ChessPiece::WBISHOP.assertEquals(ChessPiece::tryFromFenText('B'))
		ChessPiece::WQUEEN.assertEquals(ChessPiece::tryFromFenText('Q'))
		ChessPiece::WKING.assertEquals(ChessPiece::tryFromFenText('K'))

		ChessPiece::BPAWN.assertEquals(ChessPiece::tryFromFenText('p'))
		ChessPiece::BROOK.assertEquals(ChessPiece::tryFromFenText('r'))
		ChessPiece::BKNIGHT.assertEquals(ChessPiece::tryFromFenText('n'))
		ChessPiece::BBISHOP.assertEquals(ChessPiece::tryFromFenText('b'))
		ChessPiece::BQUEEN.assertEquals(ChessPiece::tryFromFenText('q'))
		ChessPiece::BKING.assertEquals(ChessPiece::tryFromFenText('k'))
	}
	
	@Test
	package def void flipColorTest(){
		ChessPiece::WPAWN.flippedColor.black.assertTrue
		ChessPiece::WROOK.flippedColor.black.assertTrue
		ChessPiece::WKNIGHT.flippedColor.black.assertTrue
		ChessPiece::WBISHOP.flippedColor.black.assertTrue
		ChessPiece::WQUEEN.flippedColor.black.assertTrue
		ChessPiece::WKING.flippedColor.black.assertTrue
		
		ChessPiece::BPAWN.flippedColor.white.assertTrue
		ChessPiece::BROOK.flippedColor.white.assertTrue
		ChessPiece::BKNIGHT.flippedColor.white.assertTrue
		ChessPiece::BBISHOP.flippedColor.white.assertTrue	
		ChessPiece::BQUEEN.flippedColor.white.assertTrue
		ChessPiece::BKING.flippedColor.white.assertTrue
	}
	
	@Test
	package def npeTest(){
		NullPointerException.assertThrows([ChessPiece::fromFenText(null)])		
	}
	
	@Test
	package def void illegalArgTest(){
		IllegalArgumentException.assertThrows([ChessPiece::fromFenChar('x'.xChar)])
		IllegalArgumentException.assertThrows([ChessPiece::fromFenText('xyz')])		
	}
	
	@Test
	package def void tryInvalidTest(){
		ChessPiece::tryFromFenText('xyz').assertNull
		ChessPiece::tryFromFenChar('x'.xChar).assertNull												
	}
	
	@Test
	package def void tryNullTest(){
		ChessPiece::tryFromFenText(null).assertNull				
	}
	
	private def char xChar(String string){ string.charAt(0) }
}