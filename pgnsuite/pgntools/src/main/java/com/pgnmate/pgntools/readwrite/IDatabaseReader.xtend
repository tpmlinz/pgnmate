package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgn.facade.IPGNDatabase

interface IDatabaseReader {	
	def IPGNDatabase read(Object source)
}