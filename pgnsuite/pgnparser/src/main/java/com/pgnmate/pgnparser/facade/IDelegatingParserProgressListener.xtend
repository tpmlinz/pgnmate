package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.IParserProgressListener

interface IDelegatingParserProgressListener extends IParserProgressListener {
	
	def IParserProgressListener getDelegate()
}