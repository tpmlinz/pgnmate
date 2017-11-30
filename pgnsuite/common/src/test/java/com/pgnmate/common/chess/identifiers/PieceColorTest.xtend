package com.pgnmate.common.chess.identifiers

import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*

@DisplayName("PieceColor Test")
class PieceColorTest extends AbstractCommonTest{
	
	@Test
	package def void toFenTextTest(){
		
		'w'.assertEquals(PieceColor::WHITE.toFenText)
		'b'.assertEquals(PieceColor::BLACK.toFenText)		
	}
	
	@Test
	package def void toFenCharTest(){		
		'w'.charAt(0).assertEquals(PieceColor::WHITE.toFenChar)
		'b'.charAt(0).assertEquals(PieceColor::BLACK.toFenChar)		
	}
	
	@Test
	package def void fromFenTextTest(){
		PieceColor::WHITE.assertEquals(PieceColor::fromFenText("w"))
		PieceColor::BLACK.assertEquals(PieceColor::fromFenText("b"))		
	}
	
	@Test
	package def void fromFenCharTest(){
		PieceColor::WHITE.assertEquals(PieceColor::fromFenChar("w".charAt(0)))
		PieceColor::BLACK.assertEquals(PieceColor::fromFenChar("b".charAt(0)))	
	}
	
	@Test
	package def void tryFromFenTextTest(){
		PieceColor::WHITE.assertEquals(PieceColor::tryFromFenText("w"))
		PieceColor::BLACK.assertEquals(PieceColor::tryFromFenText("b"))	
	}
	
	@Test
	package def void tryFromFenCharTest(){
		PieceColor::WHITE.assertEquals(PieceColor::tryFromFenChar("w".charAt(0)))
		PieceColor::BLACK.assertEquals(PieceColor::tryFromFenChar("b".charAt(0)))	
	}
	
	@Test
	package def void npeTest(){
		NullPointerException.assertThrows([PieceColor::fromFenText(null)])
	}
	
	@Test
	package def void illegalArgTest(){
		IllegalArgumentException.assertThrows([PieceColor::fromFenText("x")])
		IllegalArgumentException.assertThrows([PieceColor::fromFenChar("x".charAt(0))])		
	}
	
	@Test
	package def void tryNullFenTextTest(){
		null.assertEquals(PieceColor::tryFromFenText(null))
	}
	
	@Test
	package def void tryInvalidFenTextTest(){
		null.assertEquals(PieceColor::tryFromFenText("x"))
	}
	
	@Test
	package def void tryInvalidFenCharTest(){
		null.assertEquals(PieceColor::tryFromFenChar("x".charAt(0)))
	}
}