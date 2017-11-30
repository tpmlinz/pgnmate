package com.pgnmate.pgnparser.pgnnode.module

import com.pgnmate.pgnparser.pgnnode.IPGNDatabase
import com.pgnmate.pgnparser.pgnnode.IPGNGame
import java.util.List
import java.util.Collections
import java.util.Collection
import com.pgnmate.pgnparser.pgnnode.IPGNNode

package class PGNDatabase extends AbstractPGNNode implements IPGNDatabase{
					
	val games = <IPGNGame>newArrayList		
	override getGames(){ games }	
	override getChildren(){ Collections::unmodifiableCollection((games) as List) }

}
