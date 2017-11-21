package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.IPGNNode;
import com.pgnmate.pgn.facade.IPGNTagPair;
import java.util.Collection;

@SuppressWarnings("all")
public interface IPGNGame extends IPGNNode {
  public enum EGameResult {
    WHITE_WINS,
    
    BLACK_WINS,
    
    DRAWN,
    
    ASTERISK;
  }
  
  public abstract Collection<IPGNElement> getElements();
  
  public abstract Collection<IPGNTagPair> getTags();
  
  public abstract IPGNGame.EGameResult getResult();
  
  public abstract void setGameResult(final IPGNGame.EGameResult result);
  
  public abstract int getHalfMoveCount();
  
  public abstract Iterable<IPGNMove> getMoves();
}
