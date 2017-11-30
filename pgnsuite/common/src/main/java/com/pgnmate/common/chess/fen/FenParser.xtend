package com.pgnmate.common.chess.fen

import java.util.regex.Pattern
import com.pgnmate.common.chess.position.ChessPosition
import com.pgnmate.common.chess.identifiers.ChessPiece
import com.pgnmate.common.chess.position.IChessPosition

import static extension com.pgnmate.common.chess.identifiers.SquareId.*
import com.pgnmate.common.chess.identifiers.PieceColor
import com.pgnmate.common.chess.identifiers.CastlingRights

/**
 * FEN parser class. 
 * <p>
 * <ul>
 * <li>Parses FEN text strings to IChessPosition</li>
 * <li>Creates a FEN text String from an IChessPosition</li>
 * </p>
 */
class FenParser {
		
	static val PATTERN_STRING = "\\s*([rnbqkpRNBQKP1-8]+\\/){7}([rnbqkpRNBQKP1-8]+)\\s[bw-]\\s(([a-hkqA-HKQ]{1,4})|(-))\\s(([a-h][36])|(-))\\s\\d+\\s\\d+\\s*"
	static val PATTERN = Pattern.compile(PATTERN_STRING);
			 
	 
	/**
	 * Is syntactically valid FEN string predicate
	 * <p>
	 * This method returns true if the argument has the correct syntax. This does not imply that it is
	 * semantically valid. To check for a semantically valid FEN string see {@link #parseFen parseFen}.
	 * </p>
	 * @param fenText the FEN string to test
	 * @return true if syntactically valid FEN string and false otherwise
	 */
	def boolean isValidFen(String fenText){
		com.pgnmate.common.chess.fen.FenParser.PATTERN.matcher(fenText).matches				
	}
	
	/**
	 * Return position represnted by parsed FEN string
	 * @param fenString the FEN text representing the position. May not be <code>null</code>
	 * @return ChessPosition represented by FEN string
	 * @throws NullPointerException on <code>null</code> fenString
	 */
	def IChessPosition parseFen(String fenString){
		
		if(fenString === null) throw new NullPointerException		
		if(!fenString.validFen) throw new FenParseException
		
		val fenElements = fenString.split(" +")				
		val positionText = fenElements.get(0)
				
		val positionParser = new PositionParser
		val positionSegments = positionText.split('/')
		if(positionSegments.size != 8) throw new FenParseException
		positionSegments.forEach[positionParser.nextRank(it)]		
		val position = positionParser.done
		
		val colorToMoveText = fenElements.get(1)
		position.colorToMove = PieceColor::fromFenText(colorToMoveText)
		
		
		val castlingRightsText = fenElements.get(2)
		val rights = castlingRightsText.parseCastlingRights
		position.setCastlingRights(PieceColor::WHITE, rights.get(0))
		position.setCastlingRights(PieceColor::BLACK, rights.get(1))
		
		
		val enPassantText = fenElements.get(3)
		if(enPassantText != '-') position.enPassantSquare = enPassantText.fromSanText
		
		val halfMoveClockText = fenElements.get(4)
		position.halfMoveClock = Integer.parseInt(halfMoveClockText)
		
		val fullMoveClockText = fenElements.get(5)
		position.fullMoveClock = Integer.parseInt(fullMoveClockText)
		
		
		position
	}
	
	
	/**
	 * Returns FEN text string representation of the position
	 * @param position the position to turn into FEN text
	 * @return FEN text string. Never <code>null</code>
	 * @throws NullPointerException on <code>null</code> position argument 
	 */
	def String unparse(IChessPosition position){
		if(position === null) throw new NullPointerException
		val unparser = new PositionUnparser
		for(i : 0 ..< 64) unparser.nextPiece(position.get(i.rankReversedId))
		
		val f0 = unparser.done
		val f1 = position.colorToMove.toFenChar
		val f2 = position.unparseCastlingRights
		val f3 = position.enPassantSquare.unparseEnPassant
		val f4 = position.halfMoveClock.toString
		val f5 = position.fullMoveClock.toString		
		'''«f0» «f1» «f2» «f3» «f4» «f5»'''.toString		
	}
	
	
	
	
	
	private def parseCastlingRights(String fenText){
		
		var result = <CastlingRights>newArrayList(CastlingRights::NEITHER, CastlingRights::NEITHER)
				
		if(fenText.contains('KQ'))
			result.set(0, CastlingRights::BOTH)
		else if(fenText.contains('K'))
			result.set(0, CastlingRights::KINGSIDE)
		else if(fenText.contains('Q'))
			result.set(0, CastlingRights::QUEENSIDE)
		
		if(fenText.contains('kq'))
			result.set(1, CastlingRights::BOTH)
		else if(fenText.contains('k'))
			result.set(1, CastlingRights::KINGSIDE)
		else if(fenText.contains('q'))
			result.set(1, CastlingRights::QUEENSIDE)
				
		result	
	}
	
	
	private def unparseCastlingRights(IChessPosition position){
		val crw = position.getCastlingRights(PieceColor::WHITE)
		val crb = position.getCastlingRights(PieceColor::BLACK)
		
		if(crw == CastlingRights::NEITHER && crb == CastlingRights::NEITHER)
			'-'
		else if(crw != CastlingRights::NEITHER && crb == CastlingRights::NEITHER){
			crw.toFenText
		}
		else if(crw == CastlingRights::NEITHER && crb != CastlingRights::NEITHER){
			crb.toFenText.toLowerCase
		}
		else
			'''«crw.toFenText»«crb.toFenText.toLowerCase»'''
	}
	
	private def unparseEnPassant(int squareId){
		if(squareId == -1) '-' else squareId.toSanText
	}
	
	private static class PositionParser{
		
		static val DIGITS = #['1'.charAt(0), '8'.charAt(0)]		
		val position = new ChessPosition
		var squareId = 0		
		
		def done(){
			if(squareId != 64) throw new FenParseException
			position
		}
		
		def void nextRank(String rankString){
			if(squareId.file != 0) throw new FenParseException
			rankString.toCharArray.forEach[nextChar]			
		}
		
				
		def void nextChar(char ch){
			if(ch.digit){
				squareId += (ch - DIGITS.get(0)) + 1
			}
			else{
				val piece = ChessPiece::tryFromFenChar(ch)
				if(piece === null) throw new FenParseException
				val flippedId = squareId.rankReversedId
				position.put(flippedId, piece)
				squareId++
			}
		}
		
		private def boolean isDigit(char ch){ ch >= DIGITS.get(0) && ch <= DIGITS.get(1) }
	}
	
	
	
	private static class PositionUnparser{
		
		var counter = 0
		var emptySquareCount = 0
		val builder = new StringBuilder
		
		def void nextPiece(ChessPiece piece){

			if(!counter.validSquare) throw new FenParseException
			
			if(counter != 0 && (counter % 8) == 0){
				clearEmpty
				builder.append('/')
			}
			
			if(piece === null)
				emptySquareCount++
			else{
				clearEmpty
				builder.append(piece.toFenChar)
			}													
			counter++								
		}
		
		def private clearEmpty(){
			if(emptySquareCount != 0){
				builder.append(emptySquareCount)
				emptySquareCount = 0				
			}
		}

		def String done(){
			if(counter != 64) throw new FenParseException
			clearEmpty
			builder.toString
		}		
	}
}