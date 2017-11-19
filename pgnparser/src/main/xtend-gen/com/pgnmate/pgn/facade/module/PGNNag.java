package com.pgnmate.pgn.facade.module;

import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.IPGNNag;
import com.pgnmate.pgn.facade.module.AbstractPGNElement;

@SuppressWarnings("all")
class PGNNag extends AbstractPGNElement implements IPGNNag {
  private final static IPGNElement.ElementType elementType = IPGNElement.ElementType.NAG;
  
  @Override
  public IPGNElement.ElementType getElementType() {
    return PGNNag.elementType;
  }
  
  private int value = (-1);
  
  PGNNag() {
  }
  
  PGNNag(final int value) {
    this.value = value;
  }
  
  @Override
  public int getValue() {
    return this.value;
  }
  
  @Override
  public void setValue(final int value) {
    this.value = value;
  }
}
