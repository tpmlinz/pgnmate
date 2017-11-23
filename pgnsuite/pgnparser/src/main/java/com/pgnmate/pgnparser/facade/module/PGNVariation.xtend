package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IPGNVariation
import com.pgnmate.pgnparser.facade.IPGNNode
import java.util.Collections

package class PGNVariation extends AbstractPGNNode implements IPGNVariation{	
		
	var elements = <IPGNNode>newArrayList	
	override getElements() { this.elements }	
	override getChildren(){ Collections::unmodifiableCollection(elements) }				
	
}