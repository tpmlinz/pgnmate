package com.pgnmate.pgntools.command


/**
 * Command line parser interface
 */
interface ICommandParser {
	
	/**
	 * Parse command line arguments
	 * @param args to parse
	 */
	def void parse(String[] args)
}