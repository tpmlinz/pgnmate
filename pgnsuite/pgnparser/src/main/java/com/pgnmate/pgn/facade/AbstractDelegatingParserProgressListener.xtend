package com.pgnmate.pgn.facade

import org.eclipse.xtend.lib.annotations.Delegate

class AbstractDelegatingParserProgressListener implements IDelegatingParserProgressListener {
	
	@Delegate protected IParserProgressListener delegate	
	override getDelegate() { this.delegate }
		
}