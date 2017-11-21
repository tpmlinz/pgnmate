package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.ECastling;
import com.pgnmate.pgn.facade.ESuffix;
import com.pgnmate.pgn.facade.IPGNElement;

@SuppressWarnings("all")
public interface IPGNMove extends IPGNElement {
  /**
   * @return SAN move suffix
   */
  public abstract ESuffix getSuffix();
  
  /**
   * @return Castling type or <code>null</code> if a non-castling move
   */
  public abstract ECastling getCastling();
  
  /**
   * Set new suffix value
   * @param suffix value to set
   */
  public abstract void setSuffix(final ESuffix suffix);
  
  /**
   * Set new suffix value from String
   * @param suffix value as String
   * @Note If the String argument is not convertible to a suffix value the
   * behaviour is not defined. Some implementations may through an exception
   * or others may set the suffix to <code>null</code>. Most will probably set
   * the value of that returned by {@ref ESuffix} ESuffix which is null. Whether a String
   * is convertible to/from an ESuffix type can be checked using {@ref ESuffix} ESuffix
   * enumeration type members.
   */
  public abstract void setSuffix(final String suffix);
  
  /**
   * Remove ESuffix value. Subsequent calls to getSuffix will return <code>null</code>
   */
  public abstract void removeSuffix();
  
  /**
   * @return true if move is with check and false otherwise
   */
  public abstract boolean isCheck();
  
  /**
   * @return true if move delivers check and false otherwise
   */
  public abstract boolean isMate();
  
  /**
   * @return true if this is a capturing move and false otherwise
   */
  public abstract boolean isCapture();
  
  /**
   * @return true if move is a castling move and false otherwise
   */
  public abstract boolean isCastling();
  
  /**
   * @return the move indicator or -1 if there no move indicator present in PGN
   */
  public abstract int getMoveInicator();
  
  /**
   * Set move indicator value
   * @param value for move indicator
   */
  public abstract void setMoveInicator(final int value);
  
  /**
   * Remove move indicator if present
   */
  public abstract void clearMoveInicator();
  
  /**
   * @return SAN text of this move
   */
  public abstract String getSAN();
  
  /**
   * @param value for SAN text
   */
  public abstract void setSAN(final String value);
}
