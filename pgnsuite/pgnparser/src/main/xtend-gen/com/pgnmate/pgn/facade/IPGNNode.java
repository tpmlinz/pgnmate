package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.ENode;
import java.io.Serializable;

@SuppressWarnings("all")
public interface IPGNNode extends Serializable {
  public abstract ENode getNodeType();
}
