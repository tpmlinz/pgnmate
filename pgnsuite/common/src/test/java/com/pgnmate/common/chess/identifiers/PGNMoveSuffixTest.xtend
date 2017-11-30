package com.pgnmate.common.chess.identifiers


import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*


@DisplayName("Move Suffix Test")
class PGNMoveSuffixTest extends AbstractCommonTest{
	
	@Test
	package def void toPGNTestTest(){
		PGNMoveSuffix::GOOD.toSanText.assertEquals("!")
		PGNMoveSuffix::BRILLIANT.toSanText.assertEquals("!!")
		PGNMoveSuffix::MISTAKE.toSanText.assertEquals("?")
		PGNMoveSuffix::BLUNDER.toSanText.assertEquals("??")
		PGNMoveSuffix::INTERESTING.toSanText.assertEquals("!?")
		PGNMoveSuffix::DUBIOUS.toSanText.assertEquals("?!")				
	}
	
	@Test
	package def void fromPGNTextTest(){
		PGNMoveSuffix::GOOD.assertEquals(PGNMoveSuffix::fromSanText("!"))
		PGNMoveSuffix::BRILLIANT.assertEquals(PGNMoveSuffix::fromSanText("!!"))
		PGNMoveSuffix::MISTAKE.assertEquals(PGNMoveSuffix::fromSanText("?"))
		PGNMoveSuffix::BLUNDER.assertEquals(PGNMoveSuffix::fromSanText("??"))
		PGNMoveSuffix::INTERESTING.assertEquals(PGNMoveSuffix::fromSanText("!?"))
		PGNMoveSuffix::DUBIOUS.assertEquals(PGNMoveSuffix::fromSanText("?!"))		
	}
	
	@Test
	package def void npeTest(){
		NullPointerException.assertThrows([PGNMoveSuffix::fromSanText(null)])
	}
	
	@Test
	package def void illegalArgTest(){
		IllegalArgumentException.assertThrows([PGNMoveSuffix::fromSanText("fsdfsdf")])
	}
	
	@Test
	package def void tryInvalidTest(){
		PGNMoveSuffix::tryFromSanText("gsdgsg").assertNull
	}
	
	@Test
	package def void tryNullTest(){
		PGNMoveSuffix::tryFromSanText(null).assertNull
		
	}
}