package com.pgnmate.pgn.facade;

@SuppressWarnings("all")
public interface IParserProgressListener {
  public abstract void start(final int size);
  
  public abstract void progress(final int currentValue);
  
  public abstract void end();
}
