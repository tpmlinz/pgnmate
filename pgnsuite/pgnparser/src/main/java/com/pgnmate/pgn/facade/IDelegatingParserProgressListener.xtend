package com.pgnmate.pgn.facade

import com.pgnmate.pgn.facade.IParserProgressListener

interface IDelegatingParserProgressListener extends IParserProgressListener {
	
	def IParserProgressListener getDelegate()
}