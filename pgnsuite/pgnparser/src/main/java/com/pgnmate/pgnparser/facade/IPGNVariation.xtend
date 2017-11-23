package com.pgnmate.pgnparser.facade

import java.util.Collection

interface IPGNVariation extends IPGNElement {
	
	def Collection<IPGNElement> getElements()
}