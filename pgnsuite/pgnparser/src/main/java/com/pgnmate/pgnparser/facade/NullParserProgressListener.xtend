package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.google.inject.Singleton

@Singleton
class NullParserProgressListener implements IParserProgressListener {	
	override onProgress(IParserProgressEvent progress) {}
	
}