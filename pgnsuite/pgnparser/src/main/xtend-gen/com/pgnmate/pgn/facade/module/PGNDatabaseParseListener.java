package com.pgnmate.pgn.facade.module;

import com.google.common.base.Objects;
import com.pgnmate.pgn.PGNBaseListener;
import com.pgnmate.pgn.PGNParser;
import com.pgnmate.pgn.facade.ESuffix;
import com.pgnmate.pgn.facade.IObservableParserProgress;
import com.pgnmate.pgn.facade.IPGNDatabase;
import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.IPGNNode;
import com.pgnmate.pgn.facade.IPGNTagPair;
import com.pgnmate.pgn.facade.IPGNValidator;
import com.pgnmate.pgn.facade.IPGNVariation;
import com.pgnmate.pgn.facade.IParserProgressListener;
import com.pgnmate.pgn.facade.PGNFactory;
import java.util.ArrayDeque;
import java.util.Collection;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.apache.log4j.Logger;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.StringExtensions;

@SuppressWarnings("all")
class PGNDatabaseParseListener extends PGNBaseListener implements IObservableParserProgress {
  private final static Logger logger = Logger.getLogger(PGNDatabaseParseListener.class);
  
  /**
   * FIXME - dummy validator placeholder
   */
  private final IPGNValidator validator = new IPGNValidator() {
    @Override
    public void validate(final IPGNNode node, final Object ctx) {
    }
  };
  
  private IPGNDatabase db;
  
  public IPGNDatabase getDB() {
    return this.db;
  }
  
  private final ArrayDeque<IPGNVariation> variationStack = new ArrayDeque<IPGNVariation>();
  
  private IParserProgressListener progessListener = null;
  
  @Override
  public void setProgressListener(final IParserProgressListener listener) {
    this.progessListener = listener;
  }
  
  @Override
  public IParserProgressListener getProgressListener() {
    return this.progessListener;
  }
  
  @Override
  public void enterPgn_database(final PGNParser.Pgn_databaseContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("enterPgn_database(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    if (this.progessListener!=null) {
      this.progessListener.start(ctx.start.getInputStream().size());
    }
    this.db = PGNFactory.getInstance().createDatabase();
    this.validator.validate(this.db, ctx);
  }
  
  @Override
  public void exitPgn_database(final PGNParser.Pgn_databaseContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("exitPgn_database(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    if (this.progessListener!=null) {
      this.progessListener.end();
    }
  }
  
  @Override
  public void enterPgn_game(final PGNParser.Pgn_gameContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("enterPgn_game(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    final IPGNGame game = PGNFactory.getInstance().createGame();
    this.validator.validate(game, ctx);
    this.db.getGames().add(game);
  }
  
  @Override
  public void exitPgn_game(final PGNParser.Pgn_gameContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("exitPgn_game(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    if (this.progessListener!=null) {
      this.progessListener.progress(ctx.stop.getStopIndex());
    }
  }
  
  @Override
  public void enterTag_pair(final PGNParser.Tag_pairContext ctx) {
    final IPGNTagPair tagPair = PGNFactory.getInstance().createTagPair();
    this.validator.validate(tagPair, ctx);
    tagPair.setName(ctx.tag_name().getText());
    tagPair.setValue(ctx.tag_value().getText());
    IterableExtensions.<IPGNGame>last(this.db.getGames()).getTags().add(tagPair);
  }
  
  @Override
  public void enterGame_termination(final PGNParser.Game_terminationContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("enterGame_termination(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    IPGNGame _last = IterableExtensions.<IPGNGame>last(this.db.getGames());
    IPGNGame.EGameResult _xifexpression = null;
    TerminalNode _WHITE_WINS = ctx.WHITE_WINS();
    boolean _tripleNotEquals = (_WHITE_WINS != null);
    if (_tripleNotEquals) {
      _xifexpression = IPGNGame.EGameResult.WHITE_WINS;
    } else {
      IPGNGame.EGameResult _xifexpression_1 = null;
      TerminalNode _BLACK_WINS = ctx.BLACK_WINS();
      boolean _tripleNotEquals_1 = (_BLACK_WINS != null);
      if (_tripleNotEquals_1) {
        _xifexpression_1 = IPGNGame.EGameResult.BLACK_WINS;
      } else {
        IPGNGame.EGameResult _xifexpression_2 = null;
        TerminalNode _DRAWN_GAME = ctx.DRAWN_GAME();
        boolean _tripleNotEquals_2 = (_DRAWN_GAME != null);
        if (_tripleNotEquals_2) {
          _xifexpression_2 = IPGNGame.EGameResult.DRAWN;
        } else {
          IPGNGame.EGameResult _xifexpression_3 = null;
          TerminalNode _ASTERISK = ctx.ASTERISK();
          boolean _tripleNotEquals_3 = (_ASTERISK != null);
          if (_tripleNotEquals_3) {
            _xifexpression_3 = IPGNGame.EGameResult.ASTERISK;
          } else {
            throw new IllegalArgumentException();
          }
          _xifexpression_2 = _xifexpression_3;
        }
        _xifexpression_1 = _xifexpression_2;
      }
      _xifexpression = _xifexpression_1;
    }
    _last.setGameResult(_xifexpression);
    this.validator.validate(IterableExtensions.<IPGNGame>last(this.db.getGames()), ctx);
  }
  
  @Override
  public void exitGame_termination(final PGNParser.Game_terminationContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("exitGame_termination(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
  }
  
  @Override
  public void enterMove_element(final PGNParser.Move_elementContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("enterMove_element(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    final IPGNMove move = PGNFactory.getInstance().createMove();
    move.setSAN(ctx.san_move().getText());
    TerminalNode _INTEGER = null;
    if (ctx!=null) {
      _INTEGER=ctx.INTEGER();
    }
    String _text = null;
    if (_INTEGER!=null) {
      _text=_INTEGER.getText();
    }
    final String moveNumberText = _text;
    boolean _isNullOrEmpty = StringExtensions.isNullOrEmpty(moveNumberText);
    boolean _not = (!_isNullOrEmpty);
    if (_not) {
      final char firstChar = moveNumberText.charAt(0);
      boolean _equals = Objects.equal(Character.valueOf(firstChar), "0");
      if (_equals) {
        final Function1<Object, CharSequence> _function_1 = (Object it) -> {
          StringConcatenation _builder = new StringConcatenation();
          _builder.append("line ");
          int _line = ctx.start.getLine();
          _builder.append(_line);
          _builder.append(": ");
          int _charPositionInLine = ctx.start.getCharPositionInLine();
          _builder.append(_charPositionInLine);
          _builder.append(" Move number has leading zero");
          return _builder;
        };
        PGNDatabaseParseListener.logger.warn(_function_1);
      }
      move.setMoveInicator(Integer.parseInt(ctx.INTEGER().getText()));
      int _moveInicator = move.getMoveInicator();
      boolean _lessThan = (_moveInicator < 0);
      if (_lessThan) {
        StringConcatenation _builder = new StringConcatenation();
        _builder.append("line ");
        int _line = ctx.start.getLine();
        _builder.append(_line);
        _builder.append(": ");
        int _charPositionInLine = ctx.start.getCharPositionInLine();
        _builder.append(_charPositionInLine);
        _builder.append(" Move number has leading zero");
        final String msg = _builder.toString();
        PGNDatabaseParseListener.logger.error(msg);
        throw new ParseCancellationException(msg);
      }
    }
    TerminalNode _SUFFIX_ANNOTATION = null;
    if (ctx!=null) {
      _SUFFIX_ANNOTATION=ctx.SUFFIX_ANNOTATION();
    }
    String _text_1 = null;
    if (_SUFFIX_ANNOTATION!=null) {
      _text_1=_SUFFIX_ANNOTATION.getText();
    }
    boolean _tripleNotEquals = (_text_1 != null);
    if (_tripleNotEquals) {
      move.setSuffix(ESuffix.fromString(ctx.SUFFIX_ANNOTATION().getText()));
    }
    this.validator.validate(move, ctx);
    Collection<IPGNElement> _elvis = null;
    IPGNVariation _peek = null;
    if (this.variationStack!=null) {
      _peek=this.variationStack.peek();
    }
    Collection<IPGNElement> _elements = null;
    if (_peek!=null) {
      _elements=_peek.getElements();
    }
    if (_elements != null) {
      _elvis = _elements;
    } else {
      Collection<IPGNElement> _elements_1 = IterableExtensions.<IPGNGame>last(this.db.getGames()).getElements();
      _elvis = _elements_1;
    }
    final Collection<IPGNElement> elements = _elvis;
    elements.add(move);
  }
  
  @Override
  public void exitMove_element(final PGNParser.Move_elementContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("exitMove_element(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
  }
  
  @Override
  public void enterRecursive_variation(final PGNParser.Recursive_variationContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("enterRecursive_variation(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    final IPGNVariation newVariation = PGNFactory.getInstance().createVariation();
    this.validator.validate(newVariation, ctx);
    Collection<IPGNElement> _elvis = null;
    IPGNVariation _peek = null;
    if (this.variationStack!=null) {
      _peek=this.variationStack.peek();
    }
    Collection<IPGNElement> _elements = null;
    if (_peek!=null) {
      _elements=_peek.getElements();
    }
    if (_elements != null) {
      _elvis = _elements;
    } else {
      Collection<IPGNElement> _elements_1 = IterableExtensions.<IPGNGame>last(this.db.getGames()).getElements();
      _elvis = _elements_1;
    }
    final Collection<IPGNElement> elements = _elvis;
    elements.add(newVariation);
    this.variationStack.push(newVariation);
  }
  
  @Override
  public void exitRecursive_variation(final PGNParser.Recursive_variationContext ctx) {
    final Function1<Object, CharSequence> _function = (Object it) -> {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("exitRecursive_variation(");
      String _debugString = this.toDebugString(ctx);
      _builder.append(_debugString);
      _builder.append(")");
      return _builder;
    };
    PGNDatabaseParseListener.logger.trace(_function);
    this.variationStack.pop();
  }
  
  @Override
  public void visitErrorNode(final ErrorNode node) {
  }
  
  private String toDebugString(final ParserRuleContext ctx) {
    return ctx.toString();
  }
}
