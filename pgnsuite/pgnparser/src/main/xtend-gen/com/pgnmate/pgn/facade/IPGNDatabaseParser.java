package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IObservableParserProgress;
import com.pgnmate.pgn.facade.IPGNDatabase;
import org.antlr.v4.runtime.CharStream;

/**
 * PGN Database parser interface
 */
@SuppressWarnings("all")
public interface IPGNDatabaseParser extends IObservableParserProgress {
  /**
   * Parse PGN database
   * @param charStream to read database from
   * @return Parsed PGN database. May be <code>null</code> on failure
   */
  public abstract IPGNDatabase parse(final CharStream charStream);
  
  /**
   * Convenience method automatically creates CharStream and calls parse
   * @param fileName to parse
   * @return Parsed PGN database. May be <code>null</code> on failure
   * @Note The created CharStream assumes US-ASCII charset as per PGN standard
   */
  public abstract IPGNDatabase parseFromFileName(final String fileName);
}
