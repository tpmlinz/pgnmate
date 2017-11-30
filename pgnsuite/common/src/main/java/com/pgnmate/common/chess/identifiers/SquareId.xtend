package com.pgnmate.common.chess.identifiers

/**
 * Xtend static extension (or java utility) class for chessboard square identifiers.
 * Provides methods for converting between rank/file representation nad flat id and 
 * also between san text representation ('e4', 'f6' etc.) and int indentifiers. 
 */
class SquareId {
		
	static val FILES = #[ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h' ]
	static val char FIRST_LETTER = 'a'
	static val char LAST_LETTER = 'h'
	static val char FIRST_DIGIT = '1'
	static val char LAST_DIGIT = '8'
			
	/**
	 * Valid square predicate
	 * @param square the square to test
	 * @return true of square is valid and false otherwise
	 */
	static def boolean isValidSquare(int square){ 
		square >= 0 && square < 64
	}
	
	/**
	 * Returns the rank for the square
	 * @param square the square id
	 * @return the rank of this square
	 * @throws IllegalArgumentException on invalid square argument
	 */
	static def int getRank(int square){
		if(!square.isValidSquare) throw new IllegalArgumentException
		square / 8
	}
	
	
	/**
	 * Returns the file for the square
	 * @param square the square id
	 * @return the file of this square
	 * @throws IllegalArgumentException on invalid square argument
	 */
	static def int getFile(int square){
		if(!square.isValidSquare) throw new IllegalArgumentException
		square % 8
	}
	
	
	/**
	 * Returns square id from rank and file ids
	 * @param rank the rank id (ranks 0-7)
	 * @param file the file id (files 0-7)
	 * @return the square id (squares 0-63)
	 * @throws IllegalArgumentException on invalid rank or file
	 */
	def static getSquareId(int rank, int file) {
		if(rank < 0 || rank > 7) throw new IllegalArgumentException
		if(file < 0 || file > 7) throw new IllegalArgumentException
		rank*8 + file
	}
	
	/**
	 * Returns san text representation of the square
	 * @param square to convert to san text
	 * @return san text representation of the square id
	 * @thows IllegalArgumentException on invalud square
	 */
	static def String toSanText(int square){
		if(!square.isValidSquare) throw new IllegalArgumentException
		FILES.get(square.file) + (square.rank + 1).toString	
	}

	/**
	 * Returns the square id represnted by the san text
	 * @param sanText the san text representation of the square (e4, f6 etc)
	 * @return the squre id for the san text
	 * @throws IllegalArgumentException on invalid sanText argument
	 * @throws NullPointerException on <code>null</code> sanText argument
	 */	
	static def int fromSanText(String sanText){
		if(sanText === null) throw new NullPointerException
		if(sanText.length != 2) throw new IllegalArgumentException
		val letter = sanText.charAt(0)
		if(letter < FIRST_LETTER || letter > LAST_LETTER) throw new IllegalArgumentException
		val digit = sanText.charAt(1)
		if(digit < FIRST_DIGIT || digit > LAST_DIGIT) throw new IllegalArgumentException		
		return (letter - FIRST_LETTER) + 8*(digit - FIRST_DIGIT)
	}
	
	
	/**
	 * Returns the square represented by the san text
	 * @param sanText the san text representation of the square (e4, f6 etc)
	 * @return the square id for the sanText of -1 on failure
	 */
	static def int tryFromSanText(String sanText){
		var result = -1
		if(!sanText.nullOrEmpty && sanText.length == 2){
			val letter = sanText.charAt(0)
			val digit = sanText.charAt(1)
			if(letter >= FIRST_LETTER && letter <= LAST_LETTER && digit >= FIRST_DIGIT && digit <= LAST_DIGIT){
				result = (letter - FIRST_LETTER) + 8*(digit - FIRST_DIGIT)
			}
		}
		result
	}
	
	/**
	 * Returns color of square
	 * @param id the squre id
	 * @return color of square
	 * @throws IllegalArgumentException on invalid square id
	 */
	def static getSquareColor(int id){
		if(!id.validSquare) throw new IllegalArgumentException
		if((id.rank + id.file) % 2 == 0)
			PieceColor::BLACK
		else
			PieceColor::WHITE
	}
	
	/**
	 * Returns square id with ranks reversed
	 * <p>
	 * The square id for the 1st rank (a1-h1) is 0-7 and the 2nd rank (a2-h2) is 8-15.
	 * This method returns the id with the ranks reversed so that 0-7 is (a8-h8), 8-15 is (a7-h7) etc.
	 * </p>
	 * @param square the square id
	 * @return the id with ranks reversed
	 */
	def static getRankReversedId(int square){
		val flippedRank = 7 - square.rank
		val flippedFile = square.file
		getSquareId(flippedRank, flippedFile)
	}
}