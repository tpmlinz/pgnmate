package com.pgnmate.pgn.facade.module;

import com.google.common.collect.Iterables;
import com.pgnmate.pgn.facade.ENode;
import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.IPGNTagPair;
import com.pgnmate.pgn.facade.module.AbstractPGNNode;
import java.util.ArrayList;
import java.util.Collection;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
class PGNGame extends AbstractPGNNode implements IPGNGame {
  private final static ENode TYPE = ENode.GAME;
  
  @Override
  public ENode getNodeType() {
    return PGNGame.TYPE;
  }
  
  private IPGNGame.EGameResult result;
  
  private ArrayList<IPGNElement> elements = CollectionLiterals.<IPGNElement>newArrayList();
  
  private ArrayList<IPGNTagPair> tags = CollectionLiterals.<IPGNTagPair>newArrayList();
  
  PGNGame() {
  }
  
  @Override
  public Collection<IPGNTagPair> getTags() {
    return this.tags;
  }
  
  @Override
  public IPGNGame.EGameResult getResult() {
    return this.result;
  }
  
  @Override
  public void setGameResult(final IPGNGame.EGameResult result) {
    this.result = result;
  }
  
  @Override
  public Collection<IPGNElement> getElements() {
    return this.elements;
  }
  
  @Override
  public int getHalfMoveCount() {
    return IterableExtensions.size(this.getMoves());
  }
  
  @Override
  public Iterable<IPGNMove> getMoves() {
    return Iterables.<IPGNMove>filter(this.elements, IPGNMove.class);
  }
}
