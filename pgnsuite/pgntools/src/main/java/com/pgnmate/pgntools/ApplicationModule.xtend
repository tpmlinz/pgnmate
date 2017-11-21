package com.pgnmate.pgntools

import com.google.inject.AbstractModule
import com.pgnmate.pgn.facade.module.PGNParserModule
import com.pgnmate.pgntools.command.CommandParser
import com.pgnmate.pgntools.command.ICommandParser
import com.pgnmate.pgntools.readwrite.ReadWriteModule

class ApplicationModule extends AbstractModule{
	

	override protected configure() {
		bind(ICommandParser).to(CommandParser)
		install(new ReadWriteModule)
		install(new PGNParserModule)
		//bindConstant().annotatedWith(@Names.named("c")).to("30")				
	}	
}