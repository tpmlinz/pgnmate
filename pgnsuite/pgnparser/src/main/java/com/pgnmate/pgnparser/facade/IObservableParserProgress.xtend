package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.IParserProgressListener

interface IObservableParserProgress {
	
	/**
	 * Set progress listener
	 * @param listener to set. May be <code>null</code> in which case listener is removed
	 * @Note The listener must be set <b>before</b> parse method is called
	 */
	def void setProgressListener(IParserProgressListener listener)
	
	/**
	 * @return Parser progress listener. May be <code>null</code> if no listener is set
	 */
	def IParserProgressListener getProgressListener()
	
}
