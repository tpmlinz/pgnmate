package com.pgnmate.pgn.facade.module;

import com.pgnmate.pgn.facade.ENode;
import com.pgnmate.pgn.facade.IPGNDatabase;
import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.module.AbstractPGNNode;
import java.util.ArrayList;
import java.util.Collection;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;

@SuppressWarnings("all")
class PGNDatabase extends AbstractPGNNode implements IPGNDatabase {
  private final static ENode TYPE = ENode.DATABASE;
  
  @Override
  public ENode getNodeType() {
    return PGNDatabase.TYPE;
  }
  
  PGNDatabase() {
  }
  
  private final ArrayList<IPGNGame> games = CollectionLiterals.<IPGNGame>newArrayList();
  
  @Override
  public Collection<IPGNGame> getGames() {
    return this.games;
  }
}
