package com.pgnmate.pgnparser.pgnnode

import java.util.Collection

interface IPGNVariation extends IPGNNode {
	
	def Collection<IPGNNode> getElements()
}