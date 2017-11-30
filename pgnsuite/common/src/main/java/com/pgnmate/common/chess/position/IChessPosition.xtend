package com.pgnmate.common.chess.position

import com.pgnmate.common.chess.position.IChessboardMap
import com.pgnmate.common.chess.identifiers.PieceColor
import com.pgnmate.common.chess.identifiers.CastlingRights

/**
 * Chess position interface
 * <p>
 * A chess position is a ChessboardMap (indicating the position of each piece) with added information
 * giving the clock values, color to move, castling rights for each player and en passant square
 * if any. This is exactly the information encoded in a FEN string.
 * </p>
 */
interface IChessPosition extends IChessboardMap {
	
	/**
	 * Returns half move clock value
	 * @return half move clock value. Never negative
	 */
	def int getHalfMoveClock()
	
	/**
	 * Sets half move clock value
	 * @param value the new half move clock value. May not be negative.
	 * @throws IllegalArgumentException on negative value
	 */
	def void setHalfMoveClock(int value)
	
	/**
	 * Returns full move clock value
	 * @return full move clock value. Never negative
	 */
	def int getFullMoveClock()
	
	/**
	 * Sets full move clock value
	 * @param value the new full move clock value. May not be negative.
	 * @throws IllegalArgumentException on negative value
	 */
	def void setFullMoveClock(int value)
	
	/**
	 * Returns color to move
	 * @return color to move. Never <code>null</code>
	 */
	def PieceColor getColorToMove()
	
	/**
	 * Sets color to move value
	 * @param color the color to move
	 * @throws NullPointerException on <code>null</code> color
	 */
	def void setColorToMove(PieceColor color)
	
	/**
	 * Returns castling rights
	 * @return castling rights. Never <code>null</code>
	 */
	def CastlingRights getCastlingRights(PieceColor color)
	
	/**
	 * Sets color to move
	 * @param color the color to move. May not be <code>null</code>
	 * @throws NullPointerException on <code>null</code> color
	 */
	def void setCastlingRights(PieceColor color, CastlingRights rights)
	
	/**
	 * Returns en passant square
	 * @return en passant square or <code>-1</code> if no en passant square
	 */
	def int getEnPassantSquare()
	
	/**
	 * Sets en passant square
	 * <p>
	 * Not every square is a valid en passant square. A valid en passant square must be one of:
	 * <ul>
	 * <li>A square on the 3rd rank</li>
	 * <li>A square on the 6th rank</li>
	 * <li>Negative one (<code>-1</code>) for no en passant square set</li>
	 * </ul>
	 * </p>
	 * @param square the en passant square or <code>-1</code> if no en passant square
	 * @throws IllegalArgumentException if invalid square
	 */
	def void setEnPassantSquare(int square)
	
}