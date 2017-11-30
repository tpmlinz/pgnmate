package com.pgnmate.common.util

import com.pgnmate.common.chess.position.IChessboardMap
import com.pgnmate.common.chess.identifiers.ChessPiece

class CommonUtil {
	
	
	/**
	 * Returns position as a text string diagram
	 */
	static def CharSequence toChequeredString(IChessboardMap boardMap){
		
		'''
		+---+---+---+---+---+---+---+---+
		«(7 .. 0).map[toChequeredRank(boardMap)].join('\n+---+---+---+---+---+---+---+---+\n')»
		+---+---+---+---+---+---+---+---+
		'''
	}
	
	
	static private def CharSequence toChequeredRank(int rankId, IChessboardMap boardMap){
		val squareId = rankId * 8
		val squares = (squareId ..< (squareId + 8)).map[boardMap.get(it)]
		val pieces = squares.map[toChecqueredSquare]	
		String.format('| %s | %s | %s | %s | %s | %s | %s | %s |', pieces.toList.toArray)
	}
	
	static private def toChecqueredSquare(ChessPiece piece){ piece?.toFenText ?: ' ' }
}