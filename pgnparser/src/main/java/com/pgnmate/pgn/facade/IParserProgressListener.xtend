package com.pgnmate.pgn.facade

interface IParserProgressListener {	
	def void start(int size)
	def void progress(int currentValue)
	def void end()
}