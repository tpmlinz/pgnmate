package com.pgnmate.pgn.facade.module

import com.google.inject.AbstractModule
import com.google.inject.name.Names

import com.pgnmate.pgn.facade.IPGNDatabase
import com.pgnmate.pgn.facade.IPGNGame
import com.pgnmate.pgn.facade.IPGNNag
import com.pgnmate.pgn.facade.IPGNTagPair
import com.pgnmate.pgn.facade.IPGNMove
import com.pgnmate.pgn.facade.IPGNVariation
import com.pgnmate.pgn.facade.IPGNDatabaseParser
import com.pgnmate.pgn.facade.IParserProgressListener
import com.pgnmate.pgn.facade.DebugParserProgressListener
import com.pgnmate.pgn.facade.NullParserProgressListener

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
		bind(IParserProgressListener).annotatedWith(Names.named("Default")).to(NullParserProgressListener)	
	}	
}