package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IPGNTagPair
import com.pgnmate.pgnparser.facade.ENode

package class PGNTagPair extends AbstractPGNNode implements IPGNTagPair {
	
	static val TYPE = ENode::TAGPAIR	
	override getNodeType() { TYPE }
	
	var String name
	var String value
	
	new(){}
	new(String name, String value){
		this.name = name
		this.value = value
	}
		
	override getName() { name }	
	override setName(String name) { this.name = name }	
	override getValue() { value }	
	override setValue(String value) { this.value = value }
		
}