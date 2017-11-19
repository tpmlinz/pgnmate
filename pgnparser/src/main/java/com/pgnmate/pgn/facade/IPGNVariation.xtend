package com.pgnmate.pgn.facade

import java.util.Collection

interface IPGNVariation extends IPGNElement {
	
	def Collection<IPGNElement> getElements()
}