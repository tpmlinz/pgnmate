package com.pgnmate.pgn.facade

import com.pgnmate.pgn.facade.IPGNElement

interface IPGNNag extends IPGNElement {
	
	def int getValue()
	def void setValue(int value)
}