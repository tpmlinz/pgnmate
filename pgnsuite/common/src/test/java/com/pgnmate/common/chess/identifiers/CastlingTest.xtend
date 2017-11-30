package com.pgnmate.common.chess.identifiers

import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*

@DisplayName("Castling Test")
class CastlingTest extends AbstractCommonTest{
	
	
	@Test
	package def void toSanTextTest(){		
		Castling::KINGSIDE.toSanText.assertEquals("O-O") //note capiltal 'oh' not digit zero
		Castling::QUEENSIDE.toSanText.assertEquals("O-O-O")		
	}
	
	@Test
	package def void fromSanTextTest(){
		Castling::KINGSIDE.assertEquals(Castling::fromSanText("O-O"))
		Castling::QUEENSIDE.assertEquals(Castling::fromSanText("O-O-O"))	
	}
	
	@Test
	package def void tryFromSanTextTest(){
		Castling::KINGSIDE.assertEquals(Castling::tryFromSanText("O-O"))
		Castling::QUEENSIDE.assertEquals(Castling::tryFromSanText("O-O-O"))
	}
	
	@Test
	package def void tryInvalidTest(){
		GameResult::tryFromSanText("dddd").assertNull
	}
	
	@Test
	package def void tryNullTest(){
		GameResult::tryFromSanText(null).assertNull		
	}
	
	@Test
	package def void npeTest(){	
		NullPointerException.assertThrows([GameResult::fromSanText(null)])
	}
	
	@Test
	package def void illegalArgTest(){
		IllegalArgumentException.assertThrows([GameResult::fromSanText("dddd")])		
	}
}