package com.pgnmate.pgnparser.pgnnode

import com.pgnmate.pgnparser.pgnnode.IPGNNode

interface IPGNTagPair extends IPGNNode {
	
	def String getName()
	def void setName(String name)	
	def String getValue()
	def void setValue(String value)
}