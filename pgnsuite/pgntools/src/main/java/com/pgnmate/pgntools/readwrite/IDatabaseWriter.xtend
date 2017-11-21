package com.pgnmate.pgntools.readwrite

import com.pgnmate.pgn.facade.IPGNDatabase

interface IDatabaseWriter {	
	def void write(IPGNDatabase db)
}