package com.pgnmate.common.chess.identifiers

import com.pgnmate.common.AbstractCommonTest
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static extension org.junit.jupiter.api.Assertions.*
import static extension com.pgnmate.common.chess.identifiers.SquareId.*

@DisplayName("Square Id Test")
class SquareIdTest extends AbstractCommonTest{
	
	//val LETTERS = <Character>newArrayList('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h')
	//val DIGITS = <Character>newArrayList('1', '2', '3', '4', '5', '6', '7', '8')
	
	val SAN_SQUARES = #[
		'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1',
		'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2',
		'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3',
		'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4',
		'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5',					
		'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6',
		'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7',
		'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8'					
	]
	
	@Test
	package def void validIdTest(){
		for(i : 0 ..< 64){
			i.validSquare.assertTrue			
		}
		(-1).validSquare.assertFalse
		64.validSquare.assertFalse
	}
	
	@Test
	package def void getRankTest(){
		(0..7).forEach[0.assertEquals(rank)]
		(8..15).forEach[1.assertEquals(rank)]
		(16..23).forEach[2.assertEquals(rank)]
		(24..31).forEach[3.assertEquals(rank)]
		(32..39).forEach[4.assertEquals(rank)]
		(40..47).forEach[5.assertEquals(rank)]
		(48..55).forEach[6.assertEquals(rank)]
		(56..63).forEach[7.assertEquals(rank)]
	}
	

	
	@Test
	package def void getFileTest(){
		for(r : 0 ..< 8)
			for(f : 0..< 8){
				val id = r*8 + f
				f.assertEquals(id.file)
			}
	}
	
	@Test
	package def void getColorTest(){
		PieceColor::BLACK.assertEquals(0.squareColor)
		PieceColor::WHITE.assertEquals(7.squareColor)
		PieceColor::BLACK.assertEquals(63.squareColor)
		PieceColor::WHITE.assertEquals(56.squareColor)
		
	}
	
	@Test
	package def void fromStanTextTest(){
		
		0.assertEquals('a1'.fromSanText)
		7.assertEquals('h1'.fromSanText)		
		56.assertEquals('a8'.fromSanText)
		63.assertEquals('h8'.fromSanText)
				
				
		for(var char r =  '1'.charAt(0); r <= '7'.charAt(0); r++){
			for(var char f = 'a'.charAt(0); f <= 'h'.charAt(0); f++){
				val san = Character::toString(f) + Character.toString(r)
				val square = san.fromSanText
				square.validSquare.assertTrue
				val int id = 8*(r - '1'.charAt(0)) + f - 'a'.charAt(0)
				id.validSquare.assertTrue
				id.assertEquals(square)
			}
		}
		
		for(i : 0 ..< SAN_SQUARES.size){
			val square = SAN_SQUARES.get(i).fromSanText
			i.assertEquals(square)
		}
	}
	
	@Test
	package def void toSanTextTest(){
		for(i : 0 ..< SAN_SQUARES.size){
			SAN_SQUARES.get(i).assertEquals(i.toSanText)
		}
	}
	
	@Test
	package def void npeTest(){
		val String san = null
		NullPointerException.assertThrows([san.fromSanText])
	}
	
	@Test
	package def void illegalArgTest(){
		IllegalArgumentException.assertThrows(["abc".fromSanText])
	}
	
	@Test
	package def void tryInvalidArgTest(){
		(-1).assertEquals("abc".tryFromSanText)
	}
	
	@Test
	package def void tryNullArgTest(){
		val String sanText = null
		(-1).assertEquals(sanText.tryFromSanText)
	}
	
	@Test
	package def void tryFromSantTextTest(){
		for(i : 0 ..< SAN_SQUARES.size){
			val square = SAN_SQUARES.get(i).tryFromSanText
			i.assertEquals(square)
		}
	}
	
	@Test
	package def void invalidRankArgTest(){
		IllegalArgumentException.assertThrows([64.rank])
		IllegalArgumentException.assertThrows([(-1).rank])
		
	}
	
	@Test
	package def void invalidFileArgTest(){
		IllegalArgumentException.assertThrows([64.file])
		IllegalArgumentException.assertThrows([(-1).file])
		
	}
	
	@Test
	package def void squareIdTest(){
		for(i : 0 ..< 64){
			val r = i.rank
			var f = i.file
			i.assertEquals(SquareId::getSquareId(r, f))
		}
	}
	
	@Test
	package def void rankReversedTest(){
		for(id : 0 ..< 64){
			val normalRank = id.rank
			val normalFile = id.file
			val reveresRankId = id.rankReversedId
			val newRank = reveresRankId.rank
			val newFile = reveresRankId.file
			assertEquals(7 - normalRank, newRank)
			assertEquals(normalFile, newFile)
		}
		
	}
}