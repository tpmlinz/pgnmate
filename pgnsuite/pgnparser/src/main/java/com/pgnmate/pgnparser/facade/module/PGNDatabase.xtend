package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IPGNDatabase
import com.pgnmate.pgnparser.facade.IPGNGame
import java.util.List
import java.util.Collections

package class PGNDatabase extends AbstractPGNNode implements IPGNDatabase{
					
	val games = <IPGNGame>newArrayList		
	override getGames(){ games }	
	override getChildren(){ Collections::unmodifiableCollection((games) as List) }				
}
