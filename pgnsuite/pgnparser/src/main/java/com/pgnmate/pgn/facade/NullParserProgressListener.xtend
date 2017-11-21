package com.pgnmate.pgn.facade

import com.google.inject.Singleton

/**
 * Singleton null parser progress listener deliberately does nothing
 */
@Singleton
class NullParserProgressListener implements IParserProgressListener{	
	override start(int endValue) {}	
	override progress(int currentValue) {}	
	override end() {}	
}