package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IPGNNode;

@SuppressWarnings("all")
public interface IPGNElement extends IPGNNode {
  public enum ElementType {
    MOVE,
    
    VARIATION,
    
    NAG;
  }
  
  public abstract IPGNElement.ElementType getElementType();
}
