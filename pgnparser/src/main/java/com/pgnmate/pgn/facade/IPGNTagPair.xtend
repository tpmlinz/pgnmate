package com.pgnmate.pgn.facade

import com.pgnmate.pgn.facade.IPGNNode

interface IPGNTagPair extends IPGNNode {
	
	def String getName()
	def void setName(String name)	
	def String getValue()
	def void setValue(String value)
}