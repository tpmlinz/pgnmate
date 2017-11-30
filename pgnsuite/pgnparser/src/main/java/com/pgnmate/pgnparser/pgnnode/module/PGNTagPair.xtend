package com.pgnmate.pgnparser.pgnnode.module

import com.pgnmate.pgnparser.pgnnode.IPGNTagPair

package class PGNTagPair extends AbstractPGNNode implements IPGNTagPair {
		
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