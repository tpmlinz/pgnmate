package com.pgnmate.pgn.facade.module

import com.pgnmate.pgn.facade.ENode
import com.pgnmate.pgn.facade.IPGNElement
import com.pgnmate.pgn.facade.IPGNGame
import com.pgnmate.pgn.facade.IPGNMove
import com.pgnmate.pgn.facade.IPGNTagPair

package class PGNGame extends AbstractPGNNode implements IPGNGame{
	
	static val TYPE = ENode::GAME	
	override getNodeType() { TYPE }
	
	var EGameResult result
	var elements = <IPGNElement>newArrayList	
	var tags = <IPGNTagPair>newArrayList
	
	package new(){}
		
	override getTags() { tags }	
	override getResult() { result }	
	override setGameResult(EGameResult result) { this.result = result }	
	override getElements() { elements }
	override int getHalfMoveCount(){ moves.size }
	override Iterable<IPGNMove> getMoves(){ elements.filter(IPGNMove) }	
}