package com.pgnmate.common.chess.identifiers

import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*


@DisplayName("GameResult Test")
class GameResultTest extends AbstractCommonTest{
	
	@Test
	package def void toPGNTextTest(){
		
		GameResult::WHITE_WINS.toSanText.assertEquals("1-0")
		GameResult::BLACK_WINS.toSanText.assertEquals("0-1")
		GameResult::DRAWN.toSanText.assertEquals("1/2-1/2")
		GameResult::UNKNOWN.toSanText.assertEquals("*")		
	}
	
	@Test
	package def void fromPGNTextTest(){
		GameResult::WHITE_WINS.assertEquals(GameResult::fromSanText("1-0"))
		GameResult::BLACK_WINS.assertEquals(GameResult::fromSanText("0-1"))
		GameResult::DRAWN.assertEquals(GameResult::fromSanText("1/2-1/2"))
		GameResult::UNKNOWN.assertEquals(GameResult::fromSanText("*"))		
	}
	
	@Test
	package def void npeTest(){		
		NullPointerException.assertThrows([GameResult::fromSanText(null)])
	}
	
	@Test
	package def void illegalArgTest(){		
		IllegalArgumentException.assertThrows([GameResult::fromSanText("gsdgsg")])
	}
	
	@Test
	package def void tryInvalidTest(){
		GameResult::tryFromSanText("gsdgsg").assertNull
	}
	
	@Test
	package def void tryNullTest(){
		GameResult::tryFromSanText(null).assertNull
	}
}