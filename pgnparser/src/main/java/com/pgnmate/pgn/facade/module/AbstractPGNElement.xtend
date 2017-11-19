package com.pgnmate.pgn.facade.module

import com.pgnmate.pgn.facade.IPGNElement
import com.pgnmate.pgn.facade.ENode

abstract package class AbstractPGNElement extends AbstractPGNNode implements IPGNElement {		
	override getNodeType() { ENode::ELEMENT }
	
}
