package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.google.inject.Singleton

@Singleton
class DebugParserProgressListener implements IParserProgressListener {

	override start(int endValue) { println('''parser start: size =  «endValue»''') }
	override progress(int currentValue) { println('''parser progress: current = «currentValue»''') }
	override end() { println('''parser progress: done''') }
}
