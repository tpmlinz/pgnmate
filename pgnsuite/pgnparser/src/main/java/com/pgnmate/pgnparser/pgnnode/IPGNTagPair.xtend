package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.IPGNNode

interface IPGNTagPair extends IPGNNode {
	
	def String getName()
	def void setName(String name)	
	def String getValue()
	def void setValue(String value)
}