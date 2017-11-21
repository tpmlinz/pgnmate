package com.pgnmate.pgn.facade

import java.util.Collection

interface IPGNGame extends IPGNNode {
	
	enum EGameResult{
		WHITE_WINS,
		BLACK_WINS,
		DRAWN,
		ASTERISK
	}
	
	def Collection<IPGNElement> getElements()	
	def Collection<IPGNTagPair> getTags()
	
	def EGameResult getResult()
	def void setGameResult(EGameResult result)
	def int getHalfMoveCount()	
	def Iterable<IPGNMove> getMoves()
}