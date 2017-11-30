package com.pgnmate.pgnparser.pgnnode

import java.io.Serializable
import java.util.Collection

/**
 * Node in a PGN tree
 * 
 */
interface IPGNNode extends Serializable {
	
	/**
	 * Returns children of this node. 
	 * 
	 * <p>
	 * An implementation my return an unmodifiable collection
	 * or a modifiable copy of the child nodes. In either case, it is not possible to modify the
	 * node's underlying child collection by modifying the return collection. For adding and removing
	 * child nodes use {@link #addChild(IPGNNode) addChild} or {@link #remmoveChild removeChild }.
	 * </p>
	 * 
	 * @return child nodes
	 */
	def Collection<IPGNNode> getChildren()
	
	/**
	 * Adds child to node's children.
	 * 
	 * @param node the child node to add
	 */
	def void addChild(IPGNNode node)
	
	/**
	 * Adds collection of nodes to this node's child collection
	 * 
	 * @param nodes the child nodes to add
	 */
	def void addChildren(Collection<IPGNNode> nodes)
	
	/**
	 * Removes child from this node's child collection.
	 * 
	 * <p>
	 * If the node is not in this node's child collection the implementation is free to silently
	 * ignore this method call
	 * </p>
	 * 
	 * @param node the child to remove
	 */
	def void removeChild(IPGNNode node)
	
	/**
	 * Removes collection of children from this node's child collection
	 * 
	 * <p>
	 * The implementation may silently ignore the request to remove any nodes of the argument collection that are not child node's while
	 * removing those that are. The semantics must be the same as calling removerChild for each element of nodes.
	 * </p>
	 * 
	 * @param nodes the nodes to remove child collection
	 */
	def void removeChildren(Collection<IPGNNode> nodes)
}