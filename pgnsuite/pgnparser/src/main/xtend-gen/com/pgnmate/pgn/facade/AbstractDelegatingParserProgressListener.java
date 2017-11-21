package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IDelegatingParserProgressListener;
import com.pgnmate.pgn.facade.IParserProgressListener;
import org.eclipse.xtend.lib.annotations.Delegate;

@SuppressWarnings("all")
public class AbstractDelegatingParserProgressListener implements IDelegatingParserProgressListener {
  @Delegate
  protected IParserProgressListener delegate;
  
  @Override
  public IParserProgressListener getDelegate() {
    return this.delegate;
  }
  
  public void start(final int size) {
    this.delegate.start(size);
  }
  
  public void progress(final int currentValue) {
    this.delegate.progress(currentValue);
  }
  
  public void end() {
    this.delegate.end();
  }
}
