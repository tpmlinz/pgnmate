package com.pgnmate.pgntools.test


import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.api.TestInstance.Lifecycle

import static extension org.junit.jupiter.api.Assertions.*

@DisplayName("Options Test")
@TestInstance(Lifecycle.PER_CLASS)
class OptionsTest extends AbstractPGNToolTest{

	@DisplayName("Dummy Test")
	@Test
	def void dummyTest(){
		//fail("bugger")
	}	
}