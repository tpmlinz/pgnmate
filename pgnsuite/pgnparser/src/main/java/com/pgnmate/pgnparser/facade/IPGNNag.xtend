package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.IPGNElement

interface IPGNNag extends IPGNElement {
	
	def int getValue()
	def void setValue(int value)
}