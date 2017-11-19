package com.pgnmate.pgn.facade;

import com.google.inject.Singleton;
import com.pgnmate.pgn.facade.IParserProgressListener;

/**
 * Singleton null parser progress listener deliberately does nothing
 */
@Singleton
@SuppressWarnings("all")
public class NullParserProgressListener implements IParserProgressListener {
  @Override
  public void start(final int endValue) {
  }
  
  @Override
  public void progress(final int currentValue) {
  }
  
  @Override
  public void end() {
  }
}
