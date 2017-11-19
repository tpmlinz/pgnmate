package com.pgnmate.pgn.facade.module;

import com.pgnmate.pgn.PGNLexer;
import com.pgnmate.pgn.PGNParser;
import com.pgnmate.pgn.facade.IPGNDatabase;
import com.pgnmate.pgn.facade.IPGNDatabaseParser;
import com.pgnmate.pgn.facade.IParserProgressListener;
import com.pgnmate.pgn.facade.module.PGNDatabaseParseListener;
import com.pgnmate.pgn.facade.module.ThrowingErrorListener;
import java.nio.charset.StandardCharsets;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.apache.log4j.Logger;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;

@SuppressWarnings("all")
class PGNDatabaseParser implements IPGNDatabaseParser {
  private final static Logger logger = Logger.getLogger(PGNDatabaseParser.class);
  
  private IParserProgressListener progressListener = null;
  
  @Override
  public IPGNDatabase parseFromFileName(final String fileName) {
    try {
      IPGNDatabase _xblockexpression = null;
      {
        final CharStream charStream = CharStreams.fromFileName(fileName, StandardCharsets.US_ASCII);
        _xblockexpression = this.parse(charStream);
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  @Override
  public IPGNDatabase parse(final CharStream charStream) {
    IPGNDatabase _xblockexpression = null;
    {
      boolean _isTraceEnabled = PGNDatabaseParser.logger.isTraceEnabled();
      if (_isTraceEnabled) {
        StringConcatenation _builder = new StringConcatenation();
        _builder.append("parse(");
        _builder.append(charStream);
        _builder.append(")");
        PGNDatabaseParser.logger.trace(_builder);
      }
      final PGNLexer lexer = new PGNLexer(charStream);
      lexer.addErrorListener(ThrowingErrorListener.getInstance());
      CommonTokenStream _commonTokenStream = new CommonTokenStream(lexer);
      final PGNParser parser = new PGNParser(_commonTokenStream);
      parser.addErrorListener(ThrowingErrorListener.getInstance());
      final ParseTreeWalker walker = new ParseTreeWalker();
      final PGNDatabaseParseListener parserListener = new PGNDatabaseParseListener();
      parserListener.setProgressListener(this.progressListener);
      final PGNParser.ParseContext tree = parser.parse();
      walker.walk(parserListener, tree);
      _xblockexpression = parserListener.getDB();
    }
    return _xblockexpression;
  }
  
  @Override
  public void setProgressListener(final IParserProgressListener listener) {
    this.progressListener = listener;
  }
  
  @Override
  public IParserProgressListener getProgressListener() {
    return this.progressListener;
  }
}
