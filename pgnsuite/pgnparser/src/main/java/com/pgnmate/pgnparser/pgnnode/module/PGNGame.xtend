package com.pgnmate.pgnparser.pgnnode.module

import com.pgnmate.pgnparser.pgnnode.IPGNGame
import com.pgnmate.pgnparser.pgnnode.IPGNMove
import com.pgnmate.pgnparser.pgnnode.IPGNTagPair
import com.pgnmate.pgnparser.pgnnode.IPGNNode

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
