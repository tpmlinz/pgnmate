package com.pgnmate.pgnparser.pgnnode.module

import com.pgnmate.pgnparser.pgnnode.IPGNNag

package class PGNNag extends AbstractPGNNode implements IPGNNag {
	

	var value = -1
	
	package new(){}
	package new(int value){ this.value = value }
	
	override getValue() { this.value }	
	override setValue(int value) { this.value = value }	
		
}