package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.ENode
import java.io.Serializable

interface IPGNNode extends Serializable {	

	def ENode getNodeType()	

}