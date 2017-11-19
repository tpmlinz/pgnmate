package com.pgnmate.pgn.facade.module

import com.pgnmate.pgn.facade.ENode
import com.pgnmate.pgn.facade.IPGNDatabase
import com.pgnmate.pgn.facade.IPGNGame

package class PGNDatabase extends AbstractPGNNode implements IPGNDatabase{
			
	static val TYPE = ENode::DATABASE
	override getNodeType() { TYPE }
	
	package new(){}
		
	val games = <IPGNGame>newArrayList		
	override getGames(){ games }
			
}
