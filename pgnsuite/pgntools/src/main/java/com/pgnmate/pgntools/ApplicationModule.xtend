package com.pgnmate.pgntools

import com.google.inject.AbstractModule
import com.pgnmate.pgnparser.facade.module.PGNParserModule
import com.pgnmate.pgntools.command.CommandModule
import com.pgnmate.pgntools.readwrite.ReadWriteModule

class ApplicationModule extends AbstractModule{
	

	override protected configure() {
		install(new CommandModule)
		install(new ReadWriteModule)
		install(new PGNParserModule)
		//bindConstant().annotatedWith(@Names.named("c")).to("30")				
	}	
}