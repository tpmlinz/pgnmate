package com.pgnmate.common.chess.identifiers


import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*

@DisplayName("Castling Rights Test")
class CastlingRightsTest extends AbstractCommonTest{
	
	
	@Test
	package def void toFenTextTest(){
		
		"K".assertEquals(CastlingRights::KINGSIDE.toFenText)
		"Q".assertEquals(CastlingRights::QUEENSIDE.toFenText)
		"KQ".assertEquals(CastlingRights::BOTH.toFenText)
		"-".assertEquals(CastlingRights::NEITHER.toFenText)
	}
	
	@Test
	package def fromFenTextTest(){
		CastlingRights::KINGSIDE.assertEquals(CastlingRights::fromFenText("K"))
		CastlingRights::QUEENSIDE.assertEquals(CastlingRights::fromFenText("Q"))
		CastlingRights::BOTH.assertEquals(CastlingRights::fromFenText("KQ"))
		CastlingRights::NEITHER.assertEquals(CastlingRights::fromFenText("-"))
		
	}
	
	@Test
	package def tryFromFenTextTest(){
		CastlingRights::KINGSIDE.assertEquals(CastlingRights::tryFromFenText("K"))
		CastlingRights::QUEENSIDE.assertEquals(CastlingRights::tryFromFenText("Q"))
		CastlingRights::BOTH.assertEquals(CastlingRights::tryFromFenText("KQ"))
		CastlingRights::NEITHER.assertEquals(CastlingRights::tryFromFenText("-"))
	}
	
	@Test
	package def npeTest(){
		NullPointerException.assertThrows([CastlingRights::fromFenText(null)])
	}
	
	@Test
	package def invalidATest(){
		IllegalArgumentException.assertThrows([CastlingRights::fromFenText("hgrthtrh")])
		
	}
	
	@Test
	package def void tryInvalidTest(){
		assertNull(CastlingRights::tryFromFenText("hgrthtrh"))
	}
	
	@Test
	package def void tryNullTest(){
		assertNull(CastlingRights::tryFromFenText(null))		
	}
}