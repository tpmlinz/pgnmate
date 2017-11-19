package com.pgnmate.pgn.test;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.pgnmate.pgn.facade.module.PGNParserModule;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.junit.jupiter.api.BeforeAll;

@SuppressWarnings("all")
public abstract class AbstractParserTest {
  protected final Injector injector = Guice.createInjector(new PGNParserModule());
  
  @BeforeAll
  public void setup() {
    this.injector.injectMembers(this);
  }
  
  private final static String RESOURCE_PATH = "src/test/resources";
  
  public static String toResourcePath(final String filename) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append(AbstractParserTest.RESOURCE_PATH);
    _builder.append("/");
    _builder.append(filename);
    return _builder.toString();
  }
  
  public static String getResourcePath() {
    return AbstractParserTest.RESOURCE_PATH;
  }
}
