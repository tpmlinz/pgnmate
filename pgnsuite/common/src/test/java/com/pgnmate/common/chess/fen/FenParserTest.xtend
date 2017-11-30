package com.pgnmate.common.chess.fen

import com.pgnmate.common.AbstractCommonTest
import java.io.File
import java.util.Scanner
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*

@DisplayName("Fen Parser Test")
class FenParserTest extends AbstractCommonTest{	
	
	@Test
	package def void parseValidFenTest(){
		
		val parser = new FenParser
		
		val file = new File(getValidFenFileName)
		val scanner = new Scanner(file)
		while(scanner.hasNextLine){
			val fenString = scanner.nextLine
			parser.isValidFen(fenString).assertTrue
		}
	}
	
	@Test
	def void unparseValidFenTest(){
				
		val parser = new FenParser				
		val file = new File(getValidFenFileName)
		val scanner = new Scanner(file)
		while(scanner.hasNextLine){
			val fenText = scanner.nextLine
			val position = parser.parseFen(fenText)
			val unparsedFenText = parser.unparse(position)
			fenText.assertEquals(unparsedFenText)
		}
	}

}