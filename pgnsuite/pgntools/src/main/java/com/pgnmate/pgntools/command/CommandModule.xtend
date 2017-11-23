package com.pgnmate.pgntools.command

import com.google.inject.AbstractModule

class CommandModule extends AbstractModule {
	
	override protected configure() {
		bind(ICommandParser).to(CommandParser)
	}
	
}