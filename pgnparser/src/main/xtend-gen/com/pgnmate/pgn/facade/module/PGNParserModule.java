package com.pgnmate.pgn.facade.module;

import com.google.inject.AbstractModule;
import com.google.inject.name.Names;
import com.pgnmate.pgn.facade.DebugParserProgressListener;
import com.pgnmate.pgn.facade.IPGNDatabase;
import com.pgnmate.pgn.facade.IPGNDatabaseParser;
import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.IPGNNag;
import com.pgnmate.pgn.facade.IPGNTagPair;
import com.pgnmate.pgn.facade.IPGNVariation;
import com.pgnmate.pgn.facade.IParserProgressListener;
import com.pgnmate.pgn.facade.NullParserProgressListener;
import com.pgnmate.pgn.facade.module.LoggingParserProgressListener;
import com.pgnmate.pgn.facade.module.PGNDatabase;
import com.pgnmate.pgn.facade.module.PGNDatabaseParser;
import com.pgnmate.pgn.facade.module.PGNGame;
import com.pgnmate.pgn.facade.module.PGNMove;
import com.pgnmate.pgn.facade.module.PGNNag;
import com.pgnmate.pgn.facade.module.PGNTagPair;
import com.pgnmate.pgn.facade.module.PGNVariation;

@SuppressWarnings("all")
public class PGNParserModule extends AbstractModule {
  @Override
  protected void configure() {
    this.<IPGNDatabase>bind(IPGNDatabase.class).to(PGNDatabase.class);
    this.<IPGNGame>bind(IPGNGame.class).to(PGNGame.class);
    this.<IPGNNag>bind(IPGNNag.class).to(PGNNag.class);
    this.<IPGNTagPair>bind(IPGNTagPair.class).to(PGNTagPair.class);
    this.<IPGNMove>bind(IPGNMove.class).to(PGNMove.class);
    this.<IPGNVariation>bind(IPGNVariation.class).to(PGNVariation.class);
    this.<IPGNDatabaseParser>bind(IPGNDatabaseParser.class).to(PGNDatabaseParser.class);
    this.<IParserProgressListener>bind(IParserProgressListener.class).annotatedWith(Names.named("Logging")).to(LoggingParserProgressListener.class);
    this.<IParserProgressListener>bind(IParserProgressListener.class).annotatedWith(Names.named("Debugging")).to(DebugParserProgressListener.class);
    this.<IParserProgressListener>bind(IParserProgressListener.class).annotatedWith(Names.named("Default")).to(NullParserProgressListener.class);
  }
}
