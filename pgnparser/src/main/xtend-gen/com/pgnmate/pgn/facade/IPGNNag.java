package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IPGNElement;

@SuppressWarnings("all")
public interface IPGNNag extends IPGNElement {
  public abstract int getValue();
  
  public abstract void setValue(final int value);
}
