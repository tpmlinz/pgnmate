package com.pgnmate.pgnparser.pgnnode.module

import com.pgnmate.pgnparser.pgnnode.IPGNNode
import java.util.Collection


/**
 * Default implementation of IPGNNode.
 * 
 * <p>
 * This implementation returns an empty list as children and intentionally ignores
 * all other method calls by returning immediately without error.
 * </p>
 */
abstract package class AbstractPGNNode implements IPGNNode {	
	
	/**
	 * @return empty child collection
	 */
	override getChildren(){ emptyList }
	
	/**
	 * Does nothing and returns without error
	 */		
	override addChild(IPGNNode node){}
	
	/**
	 * Does nothing and returns without error
	 */	
	override addChildren(Collection<IPGNNode> nodes){}
	
	/**
	 * Does nothing and returns without error
	 */		
	override removeChild(IPGNNode node){}
	
	/**
	 * Does nothing and returns without error
	 */	
	override removeChildren(Collection<IPGNNode> nodes){}				
	
}
