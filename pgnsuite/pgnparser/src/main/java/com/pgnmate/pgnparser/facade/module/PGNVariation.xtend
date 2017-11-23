package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IPGNElement
import com.pgnmate.pgnparser.facade.IPGNVariation

package class PGNVariation extends AbstractPGNElement implements IPGNVariation{	
	
	static val elementType = ElementType::VARIATION	
	override getElementType() { elementType }	
	
	var elements = <IPGNElement>newArrayList	
	override getElements() { this.elements }	
	
}