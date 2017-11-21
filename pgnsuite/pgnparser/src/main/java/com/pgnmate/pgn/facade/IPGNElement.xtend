package com.pgnmate.pgn.facade


interface IPGNElement extends IPGNNode {
	
	enum ElementType{
		MOVE,
		VARIATION,
		NAG
	}
	
	def ElementType getElementType()
}