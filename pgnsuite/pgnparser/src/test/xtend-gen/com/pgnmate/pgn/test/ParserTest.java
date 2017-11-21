package com.pgnmate.pgn.test;

import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import com.google.inject.Inject;
import com.google.inject.Provider;
import com.pgnmate.pgn.facade.IPGNDatabase;
import com.pgnmate.pgn.facade.IPGNDatabaseParser;
import com.pgnmate.pgn.facade.IPGNGame;
import com.pgnmate.pgn.facade.IPGNMove;
import com.pgnmate.pgn.facade.IPGNNag;
import com.pgnmate.pgn.facade.IPGNTagPair;
import com.pgnmate.pgn.facade.IPGNVariation;
import com.pgnmate.pgn.facade.IParserProgressListener;
import com.pgnmate.pgn.facade.PGNFactory;
import com.pgnmate.pgn.facade.PGNUtils;
import com.pgnmate.pgn.test.AbstractParserTest;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.function.Consumer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.function.Executable;

@DisplayName("Database Test")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@SuppressWarnings("all")
class ParserTest extends AbstractParserTest {
  private final static List<String> PGN_FILES = ListExtensions.<String, String>map(Collections.<String>unmodifiableList(CollectionLiterals.<String>newArrayList("Adams.pgn", "Alekhine.pgn", "Anand.pgn", "Ivanchuk.pgn", "Karpov.pgn", "Kosteniuk.pgn", "Morozevich.pgn", "Shirov.pgn", "Topalov.pgn")), ((Function1<String, String>) (String it) -> {
    return AbstractParserTest.toResourcePath(it);
  }));
  
  @Inject
  private IPGNDatabase DB;
  
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
  
  @DisplayName("Inject Database")
  @Test
  void testInjectDB() {
    Assertions.assertNotNull(this.DB);
  }
  
  @DisplayName("Inject Database Provider")
  @Test
  void testDatabaseProvider() {
    final IPGNDatabase db = this.providerDB.get();
    Assertions.assertNotNull(db);
  }
  
  @DisplayName("Inject Game Provider")
  @Test
  void testGameProvider() {
    final IPGNGame game = this.providerGame.get();
    Assertions.assertNotNull(game);
  }
  
  @DisplayName("Inject NAG Provider")
  @Test
  void testNAGProvider() {
    final IPGNNag nag = this.providerNAG.get();
    Assertions.assertNotNull(nag);
  }
  
  @DisplayName("Inject Tag Pair Provider")
  @Test
  void testTagPairProvider() {
    final IPGNTagPair tag = this.providerTagPair.get();
    Assertions.assertNotNull(tag);
  }
  
  @DisplayName("Inject Move Provider")
  @Test
  void testMoveProvider() {
    final IPGNMove move = this.providerMove.get();
    Assertions.assertNotNull(move);
  }
  
  @DisplayName("Inject Variation Provider")
  @Test
  void testVariationProvider() {
    final IPGNVariation variation = this.providerVariation.get();
    Assertions.assertNotNull(variation);
  }
  
  @DisplayName("Inject Parser Provider")
  @Test
  void testParserProvider() {
    final IPGNDatabaseParser parser = this.providerParser.get();
    Assertions.assertNotNull(parser);
  }
  
  @DisplayName("Test PGN Factory")
  @Test
  void testPGNFactory() {
    Assertions.assertNotNull(PGNFactory.getInstance().createDatabase());
    Assertions.assertNotNull(PGNFactory.getInstance().createGame());
    Assertions.assertNotNull(PGNFactory.getInstance().createNAG());
    Assertions.assertNotNull(PGNFactory.getInstance().createTagPair());
    Assertions.assertNotNull(PGNFactory.getInstance().createVariation());
    Assertions.assertNotNull(PGNFactory.getInstance().createMove());
    Assertions.assertNotNull(PGNFactory.getInstance().createParser());
  }
  
  @DisplayName("Add Game to DB")
  @Test
  void testAddGame() {
    final IPGNDatabase db = PGNFactory.getInstance().createDatabase();
    final IPGNGame game = PGNFactory.getInstance().createGame();
    db.getGames().add(game);
  }
  
  @DisplayName("Parse Test1.pgn")
  @Test
  void testParseTest1_pgn() {
    final IPGNDatabase db = this.providerParser.get().parseFromFileName(AbstractParserTest.toResourcePath("Test1.pgn"));
    Assertions.assertNotNull(db);
    Assertions.assertEquals(db.getGames().size(), 1);
    final IPGNGame game = ((IPGNGame[])Conversions.unwrapArray(db.getGames(), IPGNGame.class))[0];
    Assertions.assertNotNull(game);
    Assertions.assertEquals(11, game.getTags().size());
    Assertions.assertEquals(121, game.getHalfMoveCount());
    Assertions.assertEquals(0, IterableExtensions.size(Iterables.<IPGNNag>filter(game.getElements(), IPGNNag.class)));
    this.assertTag(game, "Event", "It");
    this.assertTag(game, "Site", "Enghien les Bains FRA");
    this.assertTag(game, "Date", "2003.06.22");
    this.assertTag(game, "Round", "9");
    this.assertTag(game, "White", "Adams, Michael");
    this.assertTag(game, "Black", "Akopian, Vladimir E");
    this.assertTag(game, "Result", "1/2-1/2");
    this.assertTag(game, "WhiteElo", "2723");
    this.assertTag(game, "BlackElo", "2703");
    this.assertTag(game, "ECO", "C07");
    this.assertTag(game, "EventDate", "2003.06.13");
    Assertions.assertEquals(game.getResult(), IPGNGame.EGameResult.DRAWN);
  }
  
  @DisplayName("Parse Test2.pgn")
  @Test
  void testParseTest2_pgn() {
    final IPGNDatabase db = this.providerParser.get().parseFromFileName(AbstractParserTest.toResourcePath("Test2.pgn"));
    Assertions.assertNotNull(db);
    Assertions.assertEquals(db.getGames().size(), 1);
    final IPGNGame game = ((IPGNGame[])Conversions.unwrapArray(db.getGames(), IPGNGame.class))[0];
    Assertions.assertNotNull(game);
    Assertions.assertEquals(121, game.getHalfMoveCount());
    Assertions.assertEquals(11, game.getTags().size());
    Assertions.assertEquals(0, IterableExtensions.size(Iterables.<IPGNNag>filter(game.getElements(), IPGNNag.class)));
    this.assertTag(game, "Event", "It");
    this.assertTag(game, "Site", "Enghien les Bains FRA");
    this.assertTag(game, "Date", "2003.06.22");
    this.assertTag(game, "Round", "9");
    this.assertTag(game, "White", "Adams, Michael");
    this.assertTag(game, "Black", "Akopian, Vladimir E");
    this.assertTag(game, "Result", "1/2-1/2");
    this.assertTag(game, "WhiteElo", "2723");
    this.assertTag(game, "BlackElo", "2703");
    this.assertTag(game, "ECO", "C07");
    this.assertTag(game, "EventDate", "2003.06.13");
    Assertions.assertEquals(game.getResult(), IPGNGame.EGameResult.DRAWN);
  }
  
  @DisplayName("Parse from String")
  @Test
  void testParseString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[Event \"F/S Return Match\"]");
    _builder.newLine();
    _builder.append("[Site \"Belgrade, Serbia JUG\"]");
    _builder.newLine();
    _builder.append("[Date \"1992.11.04\"]");
    _builder.newLine();
    _builder.append("[Round \"29\"]");
    _builder.newLine();
    _builder.append("[White \"Fischer, Robert J.\"]");
    _builder.newLine();
    _builder.append("[Black \"Spassky, Boris V.\"]");
    _builder.newLine();
    _builder.append("[Result \"1/2-1/2\"]");
    _builder.newLine();
    _builder.newLine();
    _builder.append("1. e4 e5 2. Nf3 Nc6 3. Bb5 a6 {This opening is called the Ruy Lopez.}");
    _builder.newLine();
    _builder.append("4. Ba4 Nf6 5. O-O Be7 6. Re1 b5 7. Bb3 d6 8. c3 O-O 9. h3 Nb8 10. d4 Nbd7");
    _builder.newLine();
    _builder.append("11. c4 c6 12. cxb5 axb5 13. Nc3 Bb7 14. Bg5 b4 15. Nb1 h6 16. Bh4 c5 17. dxe5");
    _builder.newLine();
    _builder.append("Nxe4 18. Bxe7 Qxe7 19. exd6 Qf6 20. Nbd2 Nxd6 21. Nc4 Nxc4 22. Bxc4 Nb6");
    _builder.newLine();
    _builder.append("23. Ne5 Rae8 24. Bxf7+ Rxf7 25. Nxf7 Rxe1+ 26. Qxe1 Kxf7 27. Qe3 Qg5 28. Qxg5");
    _builder.newLine();
    _builder.append("hxg5 29. b3 Ke6 30. a3 Kd6 31. axb4 cxb4 32. Ra5 Nd5 33. f3 Bc8 34. Kf2 Bf5");
    _builder.newLine();
    _builder.append("35. Ra7 g6 36. Ra6+ Kc5 37. Ke1 Nf4 38. g3 Nxh3 39. Kd2 Kb5 40. Rd6 Kc5 41. Ra6");
    _builder.newLine();
    _builder.append("Nf2 42. g4 Bd3 43. Re6 1/2-1/2");
    _builder.newLine();
    final String pgnString = _builder.toString();
    final IPGNDatabase db = this.providerParser.get().parse(this.charSetFromString(pgnString));
    Assertions.assertEquals(db.getGames().size(), 1);
    final IPGNGame game = ((IPGNGame[])Conversions.unwrapArray(db.getGames(), IPGNGame.class))[0];
    Assertions.assertNotNull(game);
    Assertions.assertEquals(85, game.getHalfMoveCount());
    Assertions.assertEquals(7, game.getTags().size());
    this.assertTag(game, "Event", "F/S Return Match");
    this.assertTag(game, "Site", "Belgrade, Serbia JUG");
    this.assertTag(game, "Date", "1992.11.04");
    this.assertTag(game, "Round", "29");
    this.assertTag(game, "White", "Fischer, Robert J.");
    this.assertTag(game, "Black", "Spassky, Boris V.");
    this.assertTag(game, "Result", "1/2-1/2");
    Assertions.assertEquals(game.getResult(), IPGNGame.EGameResult.DRAWN);
    Assertions.assertEquals(0, IterableExtensions.size(Iterables.<IPGNNag>filter(game.getElements(), IPGNNag.class)));
    final Function1<IPGNMove, Boolean> _function = (IPGNMove it) -> {
      return Boolean.valueOf(it.isCheck());
    };
    Assertions.assertEquals(3, IterableExtensions.size(IterableExtensions.<IPGNMove>filter(game.getMoves(), _function)));
  }
  
  @DisplayName("Serialize Test")
  @Test
  void testSerialize() {
    final IPGNDatabase db1 = this.providerParser.get().parseFromFileName(AbstractParserTest.toResourcePath("Test2.pgn"));
    Assertions.assertNotNull(db1);
    final String tempFile = this.writeDB(db1);
    final IPGNDatabase db2 = this.readDB(tempFile);
    Assertions.assertNotNull(db2);
    Assertions.assertEquals(db1.getGames().size(), db2.getGames().size());
  }
  
  @Disabled
  @DisplayName("Parse All Test PGNs")
  @Test
  void testParseAllTestPGNS() {
    final IPGNDatabaseParser parser = this.providerParser.get();
    Assertions.assertNotNull(parser);
    final Consumer<String> _function = (String it) -> {
      Assertions.assertNotNull(parser.parseFromFileName(it));
    };
    ParserTest.PGN_FILES.forEach(_function);
  }
  
  @Disabled
  @DisplayName("Parse ECO Test")
  @Test
  void testParseECO() {
    IPGNDatabaseParser _get = this.providerParser.get();
    IPGNDatabase _parseFromFileName = null;
    if (_get!=null) {
      _parseFromFileName=_get.parseFromFileName(AbstractParserTest.toResourcePath("ECO.pgn"));
    }
    Assertions.assertNotNull(_parseFromFileName);
  }
  
  @DisplayName("Progress Observer Test")
  @Test
  public void testParserProgressObserver() {
    abstract class __ParserTest_1 implements IParserProgressListener {
      int previous;
    }
    
    String _resourcePath = AbstractParserTest.toResourcePath("Test2.pgn");
    final File file = new File(_resourcePath);
    final long fileLength = file.length();
    final __ParserTest_1 progessListener = new __ParserTest_1() {
      {
        previous = 0;
      }
      @Override
      public void start(final int size) {
        Assertions.assertEquals(size, fileLength);
      }
      
      @Override
      public void progress(final int currentValue) {
        Assertions.assertTrue((currentValue > this.previous));
        Assertions.assertTrue((currentValue <= fileLength));
        this.previous = currentValue;
      }
      
      @Override
      public void end() {
        Assertions.assertEquals((fileLength - 2), this.previous);
      }
    };
    final IPGNDatabaseParser parser = this.providerParser.get();
    Assertions.assertNotNull(parser);
    parser.setProgressListener(progessListener);
    Assertions.assertNotNull(parser.parseFromFileName(AbstractParserTest.toResourcePath("Test2.pgn")));
  }
  
  @DisplayName("Missing Move Elements")
  @Test
  void testNoMoves() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[Event \"F/S Return Match\"]");
    _builder.newLine();
    _builder.append("[Site \"Belgrade, Serbia JUG\"]");
    _builder.newLine();
    _builder.append("[Date \"1992.11.04\"]");
    _builder.newLine();
    _builder.append("[Round \"29\"]");
    _builder.newLine();
    _builder.append("[White \"Fischer, Robert J.\"]");
    _builder.newLine();
    _builder.append("[Black \"Spassky, Boris V.\"]");
    _builder.newLine();
    _builder.append("[Result \"1/2-1/2\"]");
    _builder.newLine();
    final String pgnString = _builder.toString();
    final Executable _function = () -> {
      this.providerParser.get().parse(this.charSetFromString(pgnString));
    };
    Assertions.<ParseCancellationException>assertThrows(ParseCancellationException.class, _function);
  }
  
  @DisplayName("Multiple Period Characters")
  @Test
  void testMuliplePersiodChars() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[Event \"F/S Return Match\"]");
    _builder.newLine();
    _builder.append("[Site \"Belgrade, Serbia JUG\"]");
    _builder.newLine();
    _builder.append("[Date \"1992.11.04\"]");
    _builder.newLine();
    _builder.append("[Round \"29\"]");
    _builder.newLine();
    _builder.append("[White \"Fischer, Robert J.\"]");
    _builder.newLine();
    _builder.append("[Black \"Spassky, Boris V.\"]");
    _builder.newLine();
    _builder.append("[Result \"1/2-1/2\"]");
    _builder.newLine();
    _builder.newLine();
    _builder.append("1...... e4 e5 1/2-1/2");
    _builder.newLine();
    final String pgnString = _builder.toString();
    final IPGNDatabase db = this.providerParser.get().parse(this.charSetFromString(pgnString));
    Assertions.assertNotNull(db);
    Assertions.assertEquals(1, db.getGames().size());
    Assertions.assertEquals(2, ((IPGNGame[])Conversions.unwrapArray(db.getGames(), IPGNGame.class))[0].getElements().size());
  }
  
  @DisplayName("Multiple x 2 Period Characters")
  @Test
  void testDoubleMultiplePeriodCharaters() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[Event \"F/S Return Match\"]");
    _builder.newLine();
    _builder.append("[Site \"Belgrade, Serbia JUG\"]");
    _builder.newLine();
    _builder.append("[Date \"1992.11.04\"]");
    _builder.newLine();
    _builder.append("[Round \"29\"]");
    _builder.newLine();
    _builder.append("[White \"Fischer, Robert J.\"]");
    _builder.newLine();
    _builder.append("[Black \"Spassky, Boris V.\"]");
    _builder.newLine();
    _builder.append("[Result \"1/2-1/2\"]");
    _builder.newLine();
    _builder.newLine();
    _builder.append("1.....e4 ......................e5 1/2-1/2");
    _builder.newLine();
    final String pgnString = _builder.toString();
    final IPGNDatabase db = this.providerParser.get().parse(this.charSetFromString(pgnString));
    Assertions.assertNotNull(db);
    Assertions.assertEquals(1, db.getGames().size());
    Assertions.assertEquals(2, ((IPGNGame[])Conversions.unwrapArray(db.getGames(), IPGNGame.class))[0].getElements().size());
  }
  
  @Disabled
  @DisplayName("Incorrect Move Numbers")
  @Test
  void testIncorrectMoveNumbers() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[Event \"F/S Return Match\"]");
    _builder.newLine();
    _builder.append("[Site \"Belgrade, Serbia JUG\"]");
    _builder.newLine();
    _builder.append("[Date \"1992.11.04\"]");
    _builder.newLine();
    _builder.append("[Round \"29\"]");
    _builder.newLine();
    _builder.append("[White \"Fischer, Robert J.\"]");
    _builder.newLine();
    _builder.append("[Black \"Spassky, Boris V.\"]");
    _builder.newLine();
    _builder.append("[Result \"1/2-1/2\"]");
    _builder.newLine();
    _builder.newLine();
    _builder.append("1. e4 e5 3. Nf3 Nc6 1/2-1/2");
    _builder.newLine();
    final String pgnString = _builder.toString();
    final Executable _function = () -> {
      this.providerParser.get().parse(this.charSetFromString(pgnString));
    };
    Assertions.<ParseCancellationException>assertThrows(ParseCancellationException.class, _function);
  }
  
  @Disabled
  @DisplayName("Leading Zero")
  @Test
  void testLeadingZero() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[Event \"F/S Return Match\"]");
    _builder.newLine();
    _builder.append("[Site \"Belgrade, Serbia JUG\"]");
    _builder.newLine();
    _builder.append("[Date \"1992.11.04\"]");
    _builder.newLine();
    _builder.append("[Round \"29\"]");
    _builder.newLine();
    _builder.append("[White \"Fischer, Robert J.\"]");
    _builder.newLine();
    _builder.append("[Black \"Spassky, Boris V.\"]");
    _builder.newLine();
    _builder.append("[Result \"1/2-1/2\"]");
    _builder.newLine();
    _builder.newLine();
    _builder.append("01. e4 e5 3. Nf3 Nc6 1/2-1/2");
    _builder.newLine();
    final String pgnString = _builder.toString();
    final Executable _function = () -> {
      this.providerParser.get().parse(this.charSetFromString(pgnString));
    };
    Assertions.<ParseCancellationException>assertThrows(ParseCancellationException.class, _function);
  }
  
  @DisplayName("Negative Move Number")
  @Test
  void testNegativeMoveNumber() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("[Event \"F/S Return Match\"]");
    _builder.newLine();
    _builder.append("[Site \"Belgrade, Serbia JUG\"]");
    _builder.newLine();
    _builder.append("[Date \"1992.11.04\"]");
    _builder.newLine();
    _builder.append("[Round \"29\"]");
    _builder.newLine();
    _builder.append("[White \"Fischer, Robert J.\"]");
    _builder.newLine();
    _builder.append("[Black \"Spassky, Boris V.\"]");
    _builder.newLine();
    _builder.append("[Result \"1/2-1/2\"]");
    _builder.newLine();
    _builder.newLine();
    _builder.append("1. e4 e5 -3. Nf3 Nc6 1/2-1/2");
    _builder.newLine();
    final String pgnString = _builder.toString();
    final Executable _function = () -> {
      this.providerParser.get().parse(this.charSetFromString(pgnString));
    };
    Assertions.<ParseCancellationException>assertThrows(ParseCancellationException.class, _function);
  }
  
  protected String writeDB(final IPGNDatabase db) {
    try {
      String _xblockexpression = null;
      {
        final File tempFile = File.createTempFile("pgn-db", ".tmp");
        final FileOutputStream fileOut = new FileOutputStream(tempFile);
        final ObjectOutputStream out = new ObjectOutputStream(fileOut);
        out.writeObject(db);
        out.close();
        fileOut.close();
        _xblockexpression = tempFile.getPath();
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  protected IPGNDatabase readDB(final String fileName) {
    try {
      IPGNDatabase _xblockexpression = null;
      {
        final FileInputStream fileIn = new FileInputStream(fileName);
        final ObjectInputStream in = new ObjectInputStream(fileIn);
        final Object object = in.readObject();
        in.close();
        fileIn.close();
        _xblockexpression = ((IPGNDatabase) object);
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  protected CharStream charSetFromString(final String string) {
    try {
      CharStream _xblockexpression = null;
      {
        byte[] _bytes = string.getBytes(StandardCharsets.US_ASCII.name());
        final ByteArrayInputStream istream = new ByteArrayInputStream(_bytes);
        _xblockexpression = CharStreams.fromStream(istream);
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  protected void assertTag(final IPGNTagPair tag, final String name, final String value) {
    Assertions.assertNotNull(tag);
    Assertions.assertNotNull(tag.getName());
    Assertions.assertNotNull(tag.getValue());
    Assertions.assertEquals(tag.getName(), name);
    Assertions.assertEquals(tag.getValue(), (("\"" + value) + "\""));
  }
  
  protected void assertTag(final IPGNGame game, final String name, final String value) {
    final Function1<IPGNTagPair, Boolean> _function = (IPGNTagPair it) -> {
      String _name = it.getName();
      return Boolean.valueOf(Objects.equal(_name, name));
    };
    final IPGNTagPair tag = IterableExtensions.<IPGNTagPair>findFirst(game.getTags(), _function);
    Assertions.assertNotNull(tag);
    this.assertTag(tag, name, value);
  }
  
  public void dump(final IPGNDatabase db) {
    final Consumer<IPGNGame> _function = (IPGNGame it) -> {
      InputOutput.<CharSequence>println(PGNUtils.decompile(it));
    };
    db.getGames().forEach(_function);
  }
}
