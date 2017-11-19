package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.IPGNNode;
import java.util.Collection;

/**
 * PGN database interface
 */
@SuppressWarnings("all")
public interface IPGNDatabase extends IPGNNode {
  /**
   * @return All games in the database
   * @Note That the returned objects may be proxies depending on the implementation
   */
  public abstract Collection<IPGNGame> getGames();
}
