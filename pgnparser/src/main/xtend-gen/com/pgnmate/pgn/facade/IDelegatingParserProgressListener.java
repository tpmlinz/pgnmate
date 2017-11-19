package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IParserProgressListener;

@SuppressWarnings("all")
public interface IDelegatingParserProgressListener extends IParserProgressListener {
  public abstract IParserProgressListener getDelegate();
}
