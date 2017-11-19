package com.pgnmate.pgn.facade.module;

import com.pgnmate.pgn.facade.ENode;
import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.module.AbstractPGNNode;

@SuppressWarnings("all")
abstract class AbstractPGNElement extends AbstractPGNNode implements IPGNElement {
  @Override
  public ENode getNodeType() {
    return ENode.ELEMENT;
  }
}
