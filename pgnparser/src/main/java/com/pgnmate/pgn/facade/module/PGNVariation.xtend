package com.pgnmate.pgn.facade.module

import com.pgnmate.pgn.facade.IPGNElement
import com.pgnmate.pgn.facade.IPGNVariation

package class PGNVariation extends AbstractPGNElement implements IPGNVariation{	
	
	static val elementType = ElementType::VARIATION	
	override getElementType() { elementType }	
	
	var elements = <IPGNElement>newArrayList	
	override getElements() { this.elements }	
	
}