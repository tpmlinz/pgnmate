package com.pgnmate.pgn.facade.module;

import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.IPGNVariation;
import com.pgnmate.pgn.facade.module.AbstractPGNElement;
import java.util.ArrayList;
import java.util.Collection;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;

@SuppressWarnings("all")
class PGNVariation extends AbstractPGNElement implements IPGNVariation {
  private final static IPGNElement.ElementType elementType = IPGNElement.ElementType.VARIATION;
  
  @Override
  public IPGNElement.ElementType getElementType() {
    return PGNVariation.elementType;
  }
  
  private ArrayList<IPGNElement> elements = CollectionLiterals.<IPGNElement>newArrayList();
  
  @Override
  public Collection<IPGNElement> getElements() {
    return this.elements;
  }
}
