package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.ESuffix;
import com.pgnmate.pgn.facade.IPGNDatabase;
import com.pgnmate.pgn.facade.IPGNElement;
import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.IPGNNag;
import com.pgnmate.pgn.facade.IPGNNode;
import com.pgnmate.pgn.facade.IPGNTagPair;
import com.pgnmate.pgn.facade.IPGNVariation;
import java.util.Arrays;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public class PGNUtils {
  protected static CharSequence _decompile(final IPGNDatabase it) {
    StringConcatenation _builder = new StringConcatenation();
    final Function1<IPGNGame, CharSequence> _function = (IPGNGame it_1) -> {
      return PGNUtils.decompile(it_1);
    };
    String _join = IterableExtensions.join(IterableExtensions.<IPGNGame, CharSequence>map(it.getGames(), _function), "\n\n");
    _builder.append(_join);
    return _builder;
  }
  
  protected static CharSequence _decompile(final IPGNGame it) {
    StringConcatenation _builder = new StringConcatenation();
    final Function1<IPGNTagPair, CharSequence> _function = (IPGNTagPair it_1) -> {
      return PGNUtils.decompile(it_1);
    };
    String _join = IterableExtensions.join(IterableExtensions.<IPGNTagPair, CharSequence>map(it.getTags(), _function), "\n");
    _builder.append(_join);
    _builder.append("\n\n");
    final Function1<IPGNElement, CharSequence> _function_1 = (IPGNElement it_1) -> {
      return PGNUtils.decompile(it_1);
    };
    String _join_1 = IterableExtensions.join(IterableExtensions.<IPGNElement, CharSequence>map(it.getElements(), _function_1), " ");
    _builder.append(_join_1);
    return _builder;
  }
  
  protected static CharSequence _decompile(final IPGNMove it) {
    StringConcatenation _builder = new StringConcatenation();
    CharSequence _moveNumberText = PGNUtils.moveNumberText(it.getMoveInicator());
    _builder.append(_moveNumberText);
    String _sAN = it.getSAN();
    _builder.append(_sAN);
    return _builder;
  }
  
  protected static CharSequence _decompile(final IPGNTagPair it) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[");
    String _name = it.getName();
    _builder.append(_name);
    _builder.append(" ");
    String _value = it.getValue();
    _builder.append(_value);
    _builder.append("]");
    return _builder;
  }
  
  protected static CharSequence _decompile(final ESuffix suffix) {
    StringConcatenation _builder = new StringConcatenation();
    CharSequence _suffixText = PGNUtils.suffixText(suffix);
    _builder.append(_suffixText);
    return _builder;
  }
  
  protected static CharSequence _decompile(final IPGNVariation it) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("(");
    final Function1<IPGNElement, CharSequence> _function = (IPGNElement it_1) -> {
      return PGNUtils.decompile(it_1);
    };
    String _join = IterableExtensions.join(IterableExtensions.<IPGNElement, CharSequence>map(it.getElements(), _function), " ");
    _builder.append(_join);
    _builder.append(")");
    return _builder;
  }
  
  protected static CharSequence _decompile(final IPGNNag it) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("$");
    int _value = it.getValue();
    _builder.append(_value);
    return _builder;
  }
  
  protected static CharSequence _decompile(final IPGNElement element) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("unknown element ");
    _builder.append(element);
    return _builder;
  }
  
  protected static CharSequence _decompile(final IPGNNode node) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("unknown node ");
    _builder.append(node);
    return _builder;
  }
  
  protected static CharSequence _decompile(final Object object) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("unknown object ");
    _builder.append(object);
    return _builder;
  }
  
  protected static CharSequence _decompile(final Void v) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("null");
    return _builder;
  }
  
  private static CharSequence suffixText(final ESuffix suffix) {
    String _elvis = null;
    String _text = null;
    if (suffix!=null) {
      _text=suffix.getText();
    }
    if (_text != null) {
      _elvis = _text;
    } else {
      _elvis = "";
    }
    return _elvis;
  }
  
  private static CharSequence moveNumberText(final int value) {
    String _xifexpression = null;
    if ((value != (-1))) {
      String _string = Integer.valueOf(value).toString();
      _xifexpression = (_string + ".");
    } else {
      _xifexpression = "";
    }
    return _xifexpression;
  }
  
  public static CharSequence decompile(final Object it) {
    if (it instanceof IPGNMove) {
      return _decompile((IPGNMove)it);
    } else if (it instanceof IPGNNag) {
      return _decompile((IPGNNag)it);
    } else if (it instanceof IPGNVariation) {
      return _decompile((IPGNVariation)it);
    } else if (it instanceof ESuffix) {
      return _decompile((ESuffix)it);
    } else if (it instanceof IPGNDatabase) {
      return _decompile((IPGNDatabase)it);
    } else if (it instanceof IPGNElement) {
      return _decompile((IPGNElement)it);
    } else if (it instanceof IPGNGame) {
      return _decompile((IPGNGame)it);
    } else if (it instanceof IPGNTagPair) {
      return _decompile((IPGNTagPair)it);
    } else if (it instanceof IPGNNode) {
      return _decompile((IPGNNode)it);
    } else if (it == null) {
      return _decompile((Void)null);
    } else if (it != null) {
      return _decompile(it);
    } else {
      throw new IllegalArgumentException("Unhandled parameter types: " +
        Arrays.<Object>asList(it).toString());
    }
  }
}
