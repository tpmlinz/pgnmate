package com.pgnmate.pgnparser.facade

import java.util.Collection

interface IPGNVariation extends IPGNNode {
	
	def Collection<IPGNNode> getElements()
}