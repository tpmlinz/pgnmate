package com.pgnmate.common.chess.position

import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*
import com.pgnmate.common.chess.identifiers.ChessPiece

@DisplayName("Chessboard Map Test")
class ChessboardMapTest extends AbstractCommonTest{
	
	@Test
	package def void nullKeyTest(){		
		val cbm = new ChessboardMap
		val Integer key = null
		NullPointerException.assertThrows([cbm.put(key, ChessPiece::WPAWN)])
	}
	
	@Test
	package def void pullNullValueTest(){
		val cbm = new ChessboardMap
		val ChessPiece piece = null
		NullPointerException.assertThrows([cbm.put(0, piece)])		
	}
	
	
	@Test
	package def invalidKeyTest(){
		val cbm = new ChessboardMap
		val piece = ChessPiece::WPAWN
		IllegalArgumentException.assertThrows([cbm.put(64, piece)])
		IllegalArgumentException.assertThrows([cbm.put(-1, piece)])		
	}
	
	@Test
	package def void correctKeyValueTest(){
		val cbm = new ChessboardMap
		val piece = ChessPiece::WPAWN
		for(key : 0 ..< 64){
			cbm.put(key, piece)
		}
		64.assertEquals(cbm.size)
	}
	
	@Test
	package def void putAllInvalidKeyTest(){
		
		val map = <Integer, ChessPiece>newHashMap
		var piece = ChessPiece::WPAWN
		map.put(64, piece)
		val cbm = new ChessboardMap
		IllegalArgumentException.assertThrows([cbm.putAll(map)])
	}
	
	@Test
	package def void putAllNullKeyTest(){
		
		val map = <Integer, ChessPiece>newHashMap
		var piece = ChessPiece::WPAWN
		val Integer key = null
		map.put(key, piece)
		val cbm = new ChessboardMap
		NullPointerException.assertThrows([cbm.putAll(map)])
	}
	
	@Test
	package def void putAllNullValueTest(){
		val map = <Integer, ChessPiece>newHashMap
		val cbm = new ChessboardMap		
		val ChessPiece piece = null
		map.put(3, piece)
		NullPointerException.assertThrows([cbm.putAll(map)])
	}
	
	@Test
	package def void putAllCorrectTest(){
		val map = <Integer, ChessPiece>newHashMap
		val cbm = new ChessboardMap
		val piece = ChessPiece::BROOK
		for(i : 0 ..< 64)
			map.put(i, piece)
			
		cbm.putAll(map)
		64.assertEquals(cbm.size)
	}
}