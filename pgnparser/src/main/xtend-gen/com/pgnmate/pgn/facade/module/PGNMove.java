package com.pgnmate.pgn.facade.module;

import com.pgnmate.pgn.facade.ECastling;
import com.pgnmate.pgn.facade.ESuffix;
import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.module.AbstractPGNElement;
import org.eclipse.xtext.xbase.lib.StringExtensions;

@SuppressWarnings("all")
class PGNMove extends AbstractPGNElement implements IPGNMove {
  private final static long serialVersionUID = 1L;
  
  private final static IPGNElement.ElementType elementType = IPGNElement.ElementType.MOVE;
  
  @Override
  public IPGNElement.ElementType getElementType() {
    return PGNMove.elementType;
  }
  
  private ESuffix suffix = null;
  
  private int moveIndicator = (-1);
  
  private String SAN;
  
  PGNMove() {
  }
  
  @Override
  public ESuffix getSuffix() {
    return this.suffix;
  }
  
  @Override
  public void setSuffix(final ESuffix suffix) {
    this.suffix = suffix;
  }
  
  @Override
  public void setSuffix(final String symbol) {
    this.suffix = ESuffix.fromString(symbol);
  }
  
  @Override
  public void removeSuffix() {
    this.suffix = null;
  }
  
  @Override
  public boolean isCheck() {
    return ((!StringExtensions.isNullOrEmpty(this.SAN)) && this.SAN.contains("+"));
  }
  
  @Override
  public boolean isMate() {
    return ((!StringExtensions.isNullOrEmpty(this.SAN)) && this.SAN.contains("#"));
  }
  
  @Override
  public boolean isCapture() {
    return ((!StringExtensions.isNullOrEmpty(this.SAN)) && this.SAN.contains("#"));
  }
  
  @Override
  public int getMoveInicator() {
    return this.moveIndicator;
  }
  
  @Override
  public void setMoveInicator(final int value) {
    this.moveIndicator = value;
  }
  
  @Override
  public void clearMoveInicator() {
    this.moveIndicator = (-1);
  }
  
  @Override
  public String getSAN() {
    return this.SAN;
  }
  
  @Override
  public void setSAN(final String value) {
    this.SAN = value;
  }
  
  @Override
  public ECastling getCastling() {
    ECastling _xblockexpression = null;
    {
      ECastling result = null;
      boolean _isNullOrEmpty = StringExtensions.isNullOrEmpty(this.SAN);
      boolean _not = (!_isNullOrEmpty);
      if (_not) {
        boolean _startsWith = this.SAN.startsWith(ECastling.KINGSIDE.getSantText());
        if (_startsWith) {
          result = ECastling.KINGSIDE;
        } else {
          boolean _startsWith_1 = this.SAN.startsWith(ECastling.QUEENSIDE.getSantText());
          if (_startsWith_1) {
            result = ECastling.QUEENSIDE;
          }
        }
      }
      _xblockexpression = result;
    }
    return _xblockexpression;
  }
  
  @Override
  public boolean isCastling() {
    ECastling _castling = this.getCastling();
    return (_castling != null);
  }
}
