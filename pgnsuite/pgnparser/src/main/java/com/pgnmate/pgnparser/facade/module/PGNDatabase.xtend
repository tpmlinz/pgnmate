package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.ENode
import com.pgnmate.pgnparser.facade.IPGNDatabase
import com.pgnmate.pgnparser.facade.IPGNGame

package class PGNDatabase extends AbstractPGNNode implements IPGNDatabase{
			
	static val TYPE = ENode::DATABASE
	override getNodeType() { TYPE }
	
	package new(){}
		
	val games = <IPGNGame>newArrayList		
	override getGames(){ games }
			
}
