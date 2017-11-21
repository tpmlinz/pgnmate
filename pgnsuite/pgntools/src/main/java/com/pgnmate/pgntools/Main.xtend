package com.pgnmate.pgntools

import com.google.inject.Guice
import com.pgnmate.pgntools.command.ICommandParser

class Main {
	
	public static val VERSION = "1.0.0"
	
	
	def static void main(String[] args) {		
		val injector = Guice.createInjector(new ApplicationModule)
		val commandParser = injector.getInstance(ICommandParser)
		
		try{	
			commandParser.parse(args)
		}
		catch(Exception ex){
			println(ex.message)
		}
		System.exit(0)		
	}
}