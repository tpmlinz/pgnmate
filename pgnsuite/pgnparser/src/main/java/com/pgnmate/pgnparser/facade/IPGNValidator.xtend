package com.pgnmate.pgnparser.facade

/**
 * <h1>PGN Semantic Validation Interface</h1>
 * For each node in the AST validate is called. The validator is call is called in normal
 * pre-order fashion (top-down starting at DB). At this point all lexing and parsing has 
 * completed and any nodes (if any) that threw exceptions have been discarded so the AST
 * is syntactically valid. This validator should check semantic validity.
 */
interface IPGNValidator {	
	def void validate(IPGNNode node, Object context)
}