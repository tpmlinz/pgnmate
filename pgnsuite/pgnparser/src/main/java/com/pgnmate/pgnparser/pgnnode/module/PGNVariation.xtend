package com.pgnmate.pgnparser.pgnnode.module

import com.pgnmate.pgnparser.pgnnode.IPGNVariation
import com.pgnmate.pgnparser.pgnnode.IPGNNode
import java.util.Collections

package class PGNVariation extends AbstractPGNNode implements IPGNVariation{	
		
	var elements = <IPGNNode>newArrayList	
	override getElements() { this.elements }	
	override getChildren(){ Collections::unmodifiableCollection(elements) }				
	
}