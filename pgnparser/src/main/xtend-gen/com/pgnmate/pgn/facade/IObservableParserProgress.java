package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IParserProgressListener;

@SuppressWarnings("all")
public interface IObservableParserProgress {
  /**
   * Set progress listener
   * @param listener to set. May be <code>null</code> in which case listener is removed
   * @Note The listener must be set <b>before</b> parse method is called
   */
  public abstract void setProgressListener(final IParserProgressListener listener);
  
  /**
   * @return Parser progress listener. May be <code>null</code> if no listener is set
   */
  public abstract IParserProgressListener getProgressListener();
}
