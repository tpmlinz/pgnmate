package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IPGNNode;

@SuppressWarnings("all")
public interface IPGNTagPair extends IPGNNode {
  public abstract String getName();
  
  public abstract void setName(final String name);
  
  public abstract String getValue();
  
  public abstract void setValue(final String value);
}
