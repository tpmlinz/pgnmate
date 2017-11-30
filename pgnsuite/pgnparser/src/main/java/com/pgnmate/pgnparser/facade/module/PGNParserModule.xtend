package com.pgnmate.pgnparser.facade.module

import com.google.inject.AbstractModule
import com.google.inject.name.Names

import com.pgnmate.pgnparser.facade.IPGNDatabaseParser
import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.pgnmate.pgnparser.facade.DebugParserProgressListener
import com.pgnmate.pgnparser.facade.NullParserProgressListener
import com.pgnmate.pgnparser.pgnnode.module.PGNNodeModule

class PGNParserModule extends AbstractModule{
	
	override protected configure() {
		
		bind(IPGNDatabaseParser).to(PGNDatabaseParser)
		bind(IParserProgressListener).annotatedWith(Names.named("Logging")).to(LoggingParserProgressListener)
		bind(IParserProgressListener).annotatedWith(Names.named("Debugging")).to(DebugParserProgressListener)
		bind(IParserProgressListener).annotatedWith(Names.named("Null")).to(NullParserProgressListener)	
		install(new PGNNodeModule)
	}	
}