package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IPGNElement;
import java.util.Collection;

@SuppressWarnings("all")
public interface IPGNVariation extends IPGNElement {
  public abstract Collection<IPGNElement> getElements();
}
