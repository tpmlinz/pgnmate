package com.pgnmate.pgn.facade;

import com.google.inject.Guice;
import com.google.inject.Inject;
import com.google.inject.Injector;
import com.google.inject.Provider;
import com.pgnmate.pgn.facade.IPGNDatabase;
import com.pgnmate.pgn.facade.IPGNDatabaseParser;
import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.IPGNNag;
import com.pgnmate.pgn.facade.IPGNTagPair;
import com.pgnmate.pgn.facade.IPGNVariation;
import com.pgnmate.pgn.facade.module.PGNParserModule;

@SuppressWarnings("all")
public class PGNFactory {
  private static PGNFactory instance;
  
  private Injector injector;
  
  @Inject
  private Provider<IPGNDatabase> providerDB;
  
  @Inject
  private Provider<IPGNGame> providerGame;
  
  @Inject
  private Provider<IPGNNag> providerNAG;
  
  @Inject
  private Provider<IPGNTagPair> providerTagPair;
  
  @Inject
  private Provider<IPGNMove> providerMove;
  
  @Inject
  private Provider<IPGNVariation> providerVariation;
  
  @Inject
  private Provider<IPGNDatabaseParser> providerParser;
  
  private PGNFactory() {
    PGNParserModule _pGNParserModule = new PGNParserModule();
    this.injector = Guice.createInjector(_pGNParserModule);
    this.injector.injectMembers(this);
  }
  
  public static PGNFactory getInstance() {
    PGNFactory _elvis = null;
    if (PGNFactory.instance != null) {
      _elvis = PGNFactory.instance;
    } else {
      PGNFactory _pGNFactory = new PGNFactory();
      PGNFactory _instance = (PGNFactory.instance = _pGNFactory);
      _elvis = _instance;
    }
    return _elvis;
  }
  
  public IPGNDatabase createDatabase() {
    return this.providerDB.get();
  }
  
  public IPGNGame createGame() {
    return this.providerGame.get();
  }
  
  public IPGNNag createNAG() {
    return this.providerNAG.get();
  }
  
  public IPGNTagPair createTagPair() {
    return this.providerTagPair.get();
  }
  
  public IPGNMove createMove() {
    return this.providerMove.get();
  }
  
  public IPGNVariation createVariation() {
    return this.providerVariation.get();
  }
  
  public IPGNDatabaseParser createParser() {
    return this.providerParser.get();
  }
}
