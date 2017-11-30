package com.pgnmate.common.exception

import com.pgnmate.common.exception.PGNException
import static extension org.junit.jupiter.api.Assertions.*
//import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
//import org.junit.jupiter.api.TestInstance


@DisplayName("Assertion Test")
class AssertionTest {
	
	static class MyException extends PGNException{		
		new(String message){ super(message) }		
		static def void throwMe(String message){ throw new MyException(message) }
	}
	
	@DisplayName("Exception Test")
	@Test
	def exceptionTest(){
		val msg = "Error Message"		
		val ex = assertThrows(MyException, [MyException::throwMe(msg)])		
		msg.assertEquals(ex.message)
	}
}