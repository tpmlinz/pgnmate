package com.pgnmate.pgn.facade;

import com.google.inject.Singleton;
import com.pgnmate.pgn.facade.IParserProgressListener;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.InputOutput;

@Singleton
@SuppressWarnings("all")
public class DebugParserProgressListener implements IParserProgressListener {
  @Override
  public void start(final int endValue) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("parser start: size =  ");
    _builder.append(endValue);
    InputOutput.<String>println(_builder.toString());
  }
  
  @Override
  public void progress(final int currentValue) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("parser progress: current = ");
    _builder.append(currentValue);
    InputOutput.<String>println(_builder.toString());
  }
  
  @Override
  public void end() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("parser progress: done");
    InputOutput.<String>println(_builder.toString());
  }
}
