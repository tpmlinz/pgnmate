package com.pgnmate.pgntools

import com.google.inject.Guice
import com.pgnmate.pgntools.command.ICommandParser

/**
 * Entry point creates injects {@link com.pgnmate.pgntools.command.CommandParser} and delegates to it
 */
class Main {
	
	/**
	 * Version text
	 */
	public static val VERSION = "1.0.0"
	
	/**
	 * Copyright text
	 */
	public static val COPYRIGHT = 
	'''
	PGN-Tools version «VERSION», Copyright (C) 2017  t.p.mcgarr 
	PGN-Tools comes with ABSOLUTELY NO WARRANTY; is free 
	software, and you are welcome to redistribute it 
	under certain conditions;.
   ''' 
	
	
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