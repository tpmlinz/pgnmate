package com.pgnmate.pgn.facade.module

import com.pgnmate.pgn.facade.IPGNNag

package class PGNNag extends AbstractPGNElement implements IPGNNag {
	
	static val elementType = ElementType::NAG	
	override getElementType() { elementType }
	
	var value = -1
	
	package new(){}
	package new(int value){ this.value = value }
	
	override getValue() { this.value }	
	override setValue(int value) { this.value = value }	
	
}