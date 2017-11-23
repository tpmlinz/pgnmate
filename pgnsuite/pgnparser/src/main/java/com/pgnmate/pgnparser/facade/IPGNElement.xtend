package com.pgnmate.pgnparser.facade


interface IPGNElement extends IPGNNode {
	
	enum ElementType{
		MOVE,
		VARIATION,
		NAG
	}
	
	def ElementType getElementType()
}