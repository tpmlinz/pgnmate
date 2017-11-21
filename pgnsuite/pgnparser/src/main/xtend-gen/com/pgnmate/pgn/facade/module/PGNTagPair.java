package com.pgnmate.pgn.facade.module;

import com.pgnmate.pgn.facade.ENode;
import com.pgnmate.pgn.facade.IPGNTagPair;
import com.pgnmate.pgn.facade.module.AbstractPGNNode;

@SuppressWarnings("all")
class PGNTagPair extends AbstractPGNNode implements IPGNTagPair {
  private final static ENode TYPE = ENode.TAGPAIR;
  
  @Override
  public ENode getNodeType() {
    return PGNTagPair.TYPE;
  }
  
  private String name;
  
  private String value;
  
  public PGNTagPair() {
  }
  
  public PGNTagPair(final String name, final String value) {
    this.name = name;
    this.value = value;
  }
  
  @Override
  public String getName() {
    return this.name;
  }
  
  @Override
  public void setName(final String name) {
    this.name = name;
  }
  
  @Override
  public String getValue() {
    return this.value;
  }
  
  @Override
  public void setValue(final String value) {
    this.value = value;
  }
}
