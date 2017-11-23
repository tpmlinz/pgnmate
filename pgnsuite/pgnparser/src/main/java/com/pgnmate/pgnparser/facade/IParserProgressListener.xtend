package com.pgnmate.pgnparser.facade

interface IParserProgressListener {	
	def void start(int size)
	def void progress(int currentValue)
	def void end()
}