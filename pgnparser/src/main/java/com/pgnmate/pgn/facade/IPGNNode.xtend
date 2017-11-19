package com.pgnmate.pgn.facade

import com.pgnmate.pgn.facade.ENode
import java.io.Serializable

interface IPGNNode extends Serializable {	

	def ENode getNodeType()	

}