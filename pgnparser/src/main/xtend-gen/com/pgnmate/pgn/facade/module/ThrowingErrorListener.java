package com.pgnmate.pgn.facade.module;

import org.antlr.v4.runtime.BaseErrorListener;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.misc.ParseCancellationException;

@SuppressWarnings("all")
class ThrowingErrorListener extends BaseErrorListener {
  private final static ThrowingErrorListener instance = new ThrowingErrorListener();
  
  public static ThrowingErrorListener getInstance() {
    return ThrowingErrorListener.instance;
  }
  
  @Override
  public void syntaxError(final Recognizer<?, ?> recognizer, final Object offendingSymbol, final int line, final int charPositionInLine, final String msg, final RecognitionException e) throws ParseCancellationException {
    throw new ParseCancellationException(((((("line " + Integer.valueOf(line)) + ":") + Integer.valueOf(charPositionInLine)) + " ") + msg));
  }
}
