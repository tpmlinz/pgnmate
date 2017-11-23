package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IPGNGame
import com.pgnmate.pgnparser.facade.IPGNMove
import com.pgnmate.pgnparser.facade.IPGNTagPair
import com.pgnmate.pgnparser.facade.IPGNNode

package class PGNGame extends AbstractPGNNode implements IPGNGame{
	
	
	var EGameResult result
	var elements = <IPGNNode>newArrayList	
	var tags = <IPGNTagPair>newArrayList
	
	package new(){}
		
	override getTags() { tags }	
	override getResult() { result }	
	override setGameResult(EGameResult result) { this.result = result }	
	override getElements() { elements }
	override int getHalfMoveCount(){ moves.size }
	
	
	override Iterable<IPGNMove> getMoves(){ elements.filter(IPGNMove) }	
	override getChildren(){ (tags + elements).toList }					
		
}
