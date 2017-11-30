package com.pgnmate.pgnparser.pgnnode.module

import com.google.inject.AbstractModule
import com.pgnmate.pgnparser.pgnnode.IPGNDatabase
import com.pgnmate.pgnparser.pgnnode.IPGNGame
import com.pgnmate.pgnparser.pgnnode.IPGNNag
import com.pgnmate.pgnparser.pgnnode.IPGNTagPair
import com.pgnmate.pgnparser.pgnnode.IPGNMove
import com.pgnmate.pgnparser.pgnnode.IPGNVariation

class PGNNodeModule extends AbstractModule{
	
	override protected configure() {
		bind(IPGNDatabase).to(PGNDatabase)
		bind(IPGNGame).to(PGNGame)
		bind(IPGNNag).to(PGNNag)
		bind(IPGNTagPair).to(PGNTagPair)
		bind(IPGNMove).to(PGNMove)
		bind(IPGNVariation).to(PGNVariation)
	}
	
}