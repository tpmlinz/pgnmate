package com.pgnmate.pgnparser.facade.module

import com.google.inject.AbstractModule
import com.google.inject.name.Names

import com.pgnmate.pgnparser.facade.IPGNDatabase
import com.pgnmate.pgnparser.facade.IPGNGame
import com.pgnmate.pgnparser.facade.IPGNNag
import com.pgnmate.pgnparser.facade.IPGNTagPair
import com.pgnmate.pgnparser.facade.IPGNMove
import com.pgnmate.pgnparser.facade.IPGNVariation
import com.pgnmate.pgnparser.facade.IPGNDatabaseParser
import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.pgnmate.pgnparser.facade.DebugParserProgressListener
import com.pgnmate.pgnparser.facade.NullParserProgressListener

class PGNParserModule extends AbstractModule{
	
	override protected configure() {
		bind(IPGNDatabase).to(PGNDatabase)
		bind(IPGNGame).to(PGNGame)
		bind(IPGNNag).to(PGNNag)
		bind(IPGNTagPair).to(PGNTagPair)
		bind(IPGNMove).to(PGNMove)
		bind(IPGNVariation).to(PGNVariation)
		bind(IPGNDatabaseParser).to(PGNDatabaseParser)
		bind(IParserProgressListener).annotatedWith(Names.named("Logging")).to(LoggingParserProgressListener)
		bind(IParserProgressListener).annotatedWith(Names.named("Debugging")).to(DebugParserProgressListener)
		bind(IParserProgressListener).annotatedWith(Names.named("Null")).to(NullParserProgressListener)	
	}	
}