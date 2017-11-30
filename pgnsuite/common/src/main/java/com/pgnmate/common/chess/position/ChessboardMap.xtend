package com.pgnmate.common.chess.position

import com.pgnmate.common.chess.identifiers.ChessPiece
import java.util.Map
import org.eclipse.xtend.lib.annotations.Delegate
import static extension com.pgnmate.common.chess.identifiers.SquareId.*


class ChessboardMap implements IChessboardMap{
	
	@Delegate Map<Integer, ChessPiece> map = newHashMap	
	
	
	/**
	 * Puts checked key/value pair into the map
	 * @param square the square to place the piece
	 * @param piece thepiece to place on the square
	 * @throws NullPointerException if either key or piece are null
	 * @throws IllegalArgumentException if key is not a valid square
	 */
	override put(Integer square, ChessPiece piece) {
		if(square === null) throw new NullPointerException
		if(!square.validSquare) throw new IllegalArgumentException
		if(piece === null) throw new NullPointerException
		map.put(square, piece)
	}
	
	/**
	 * Places multiple elements in map
	 * @param other the map elements to add
	 * @throws NullPointerException if either key or piece are null
	 * @throws IllegalArgumentException if key is not a valid square 
	 */
	override putAll(Map<? extends Integer, ? extends ChessPiece> other) {
		
		if(other.keySet.findFirst[it === null] !== null) throw new NullPointerException
		if(other.keySet.findFirst[!it.validSquare] !== null) throw new IllegalArgumentException
		
		// can't see why this doesn't pass but statement below passes test
		//if(other.values.findFirst[it === null] !== null) throw new NullPointerException
		
		for(v : other.values) if(v === null) throw new NullPointerException
		
		map.putAll(other)
	}	
}