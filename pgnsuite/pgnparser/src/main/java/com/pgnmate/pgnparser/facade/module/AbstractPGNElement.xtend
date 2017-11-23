package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IPGNElement
import com.pgnmate.pgnparser.facade.ENode

abstract package class AbstractPGNElement extends AbstractPGNNode implements IPGNElement {		
	override getNodeType() { ENode::ELEMENT }
	
}
