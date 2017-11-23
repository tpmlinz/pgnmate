package com.pgnmate.pgnparser.facade

interface IParserProgressEvent{
	static val int EV_START = 0
	static val int EV_UPDATE = 1
	static val int EV_DONE = 2
	
	def int getEventID()
	def int getCurrent()
	def int getSize()
}

interface IParserProgressListener {		
	def void onProgress(IParserProgressEvent progress)
}