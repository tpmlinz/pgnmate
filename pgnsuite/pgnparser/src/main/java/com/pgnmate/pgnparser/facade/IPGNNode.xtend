package com.pgnmate.pgnparser.facade

import java.io.Serializable
import java.util.Collection

interface IPGNNode extends Serializable {
	def Collection<IPGNNode> getChildren()
}