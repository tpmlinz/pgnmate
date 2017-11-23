package com.pgnmate.pgnparser.facade

import com.google.inject.Inject
import com.google.inject.Provider
import com.pgnmate.pgnparser.facade.IPGNDatabase
import com.pgnmate.pgnparser.facade.IPGNDatabaseParser
import com.pgnmate.pgnparser.facade.IPGNGame
import com.pgnmate.pgnparser.facade.IPGNMove
import com.pgnmate.pgnparser.facade.IPGNNag
import com.pgnmate.pgnparser.facade.IPGNTagPair
import com.pgnmate.pgnparser.facade.IPGNVariation
import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.pgnmate.pgnparser.facade.PGNFactory
import java.io.ByteArrayInputStream
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.ObjectInputStream
import java.io.ObjectOutputStream
import java.nio.charset.StandardCharsets
import org.antlr.v4.runtime.CharStreams
import org.antlr.v4.runtime.misc.ParseCancellationException
import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.api.TestInstance.Lifecycle

import static extension com.pgnmate.pgnparser.facade.PGNUtils.*
import static extension org.junit.jupiter.api.Assertions.*

@DisplayName("Database Test")
@TestInstance(Lifecycle.PER_CLASS)
package class ParserTest extends AbstractParserTest{
	
	static val PGN_FILES = #[
		"Adams.pgn",
		"Alekhine.pgn",
		"Anand.pgn",
		"Ivanchuk.pgn",
		"Karpov.pgn",
		"Kosteniuk.pgn",
		"Morozevich.pgn",
		"Shirov.pgn",
		"Topalov.pgn"
	].map[toResourcePath]
	
	@Inject IPGNDatabase DB
	@Inject Provider<IPGNDatabase> providerDB
	@Inject Provider<IPGNGame> providerGame
	@Inject Provider<IPGNNag> providerNAG
	@Inject Provider<IPGNTagPair> providerTagPair
	@Inject Provider<IPGNMove> providerMove
	@Inject Provider<IPGNVariation> providerVariation
	@Inject Provider<IPGNDatabaseParser> providerParser
		
	@DisplayName("Inject Database")		
	@Test
	def package void testInjectDB() {		
		assertNotNull(DB)		
	}
	
	@DisplayName("Inject Database Provider")	
	@Test
	def package void testDatabaseProvider(){
		val db = providerDB.get
		assertNotNull(db)
	}
	
	@DisplayName("Inject Game Provider")
	@Test
	def package void testGameProvider(){
		val game = providerGame.get
		assertNotNull(game)
	}
	
	@DisplayName("Inject NAG Provider")
	@Test
	def package void testNAGProvider(){
		val nag = providerNAG.get
		assertNotNull(nag)
	}
	
	@DisplayName("Inject Tag Pair Provider")
	@Test
	def package void testTagPairProvider(){
		val tag = providerTagPair.get
		assertNotNull(tag)
	}
	
	@DisplayName("Inject Move Provider")
	@Test
	def package void testMoveProvider(){
		val move = providerMove.get
		assertNotNull(move)
	}
	
	@DisplayName("Inject Variation Provider")
	@Test
	def package void testVariationProvider(){
		val variation = providerVariation.get
		assertNotNull(variation)
	}
	
	@DisplayName("Inject Parser Provider")
	@Test
	def package void testParserProvider(){
		val parser = providerParser.get
		assertNotNull(parser)
	}	
	
	@DisplayName("Test PGN Factory")
	@Test
	def package void testPGNFactory(){
		assertNotNull(PGNFactory::instance.createDatabase)
		assertNotNull(PGNFactory::instance.createGame)
		assertNotNull(PGNFactory::instance.createNAG)
		assertNotNull(PGNFactory::instance.createTagPair)
		assertNotNull(PGNFactory::instance.createVariation)
		assertNotNull(PGNFactory::instance.createMove)
		assertNotNull(PGNFactory::instance.createParser)
	}
	
	@DisplayName("Add Game to DB")
	@Test
	def package void testAddGame(){
		val db = PGNFactory::instance.createDatabase
		val game = PGNFactory::instance.createGame
		db.games.add(game)
	}
	
	@DisplayName("Parse Test1.pgn")
	@Test
	def package void testParseTest1_pgn(){
		val db = providerParser.get.parseFromFileName("Test1.pgn".toResourcePath)
		db.assertNotNull
		db.games.size.assertEquals(1)
		val game = db.games.get(0)
		game.assertNotNull
		
		11.assertEquals(game.tags.size)
		121.assertEquals(game.halfMoveCount)
		
		0.assertEquals(game.elements.filter(IPGNNag).size)
						
		game.assertTag("Event", "It")
		game.assertTag("Site", "Enghien les Bains FRA")
		game.assertTag("Date", "2003.06.22")
		game.assertTag("Round", "9")
		game.assertTag("White", "Adams, Michael")
		game.assertTag("Black", "Akopian, Vladimir E")		
		game.assertTag("Result", "1/2-1/2")
		game.assertTag("WhiteElo", "2723")
		game.assertTag("BlackElo", "2703")
		game.assertTag("ECO", "C07")
		game.assertTag("EventDate", "2003.06.13")										
		game.result.assertEquals(IPGNGame.EGameResult::DRAWN)
	}
	
	@DisplayName("Parse Test2.pgn")
	@Test
	def package void testParseTest2_pgn(){
		val db = providerParser.get.parseFromFileName("Test2.pgn".toResourcePath)
		assertNotNull(db)
		db.games.size.assertEquals(1)
		val game = db.games.get(0)
		game.assertNotNull
		
		121.assertEquals(game.halfMoveCount)
		11.assertEquals(game.tags.size)
		
		0.assertEquals(game.elements.filter(IPGNNag).size)		
		
		game.assertTag("Event", "It")
		game.assertTag("Site", "Enghien les Bains FRA")
		game.assertTag("Date", "2003.06.22")
		game.assertTag("Round", "9")
		game.assertTag("White", "Adams, Michael")
		game.assertTag("Black", "Akopian, Vladimir E")		
		game.assertTag("Result", "1/2-1/2")
		game.assertTag("WhiteElo", "2723")
		game.assertTag("BlackElo", "2703")
		game.assertTag("ECO", "C07")
		game.assertTag("EventDate", "2003.06.13")										
		game.result.assertEquals(IPGNGame.EGameResult::DRAWN)
	}
		
	@DisplayName("Parse from String")
	@Test
	def package void testParseString(){

		val pgnString = 
		'''
		[Event "F/S Return Match"]
		[Site "Belgrade, Serbia JUG"]
		[Date "1992.11.04"]
		[Round "29"]
		[White "Fischer, Robert J."]
		[Black "Spassky, Boris V."]
		[Result "1/2-1/2"]

		1. e4 e5 2. Nf3 Nc6 3. Bb5 a6 {This opening is called the Ruy Lopez.}
		4. Ba4 Nf6 5. O-O Be7 6. Re1 b5 7. Bb3 d6 8. c3 O-O 9. h3 Nb8 10. d4 Nbd7
		11. c4 c6 12. cxb5 axb5 13. Nc3 Bb7 14. Bg5 b4 15. Nb1 h6 16. Bh4 c5 17. dxe5
		Nxe4 18. Bxe7 Qxe7 19. exd6 Qf6 20. Nbd2 Nxd6 21. Nc4 Nxc4 22. Bxc4 Nb6
		23. Ne5 Rae8 24. Bxf7+ Rxf7 25. Nxf7 Rxe1+ 26. Qxe1 Kxf7 27. Qe3 Qg5 28. Qxg5
		hxg5 29. b3 Ke6 30. a3 Kd6 31. axb4 cxb4 32. Ra5 Nd5 33. f3 Bc8 34. Kf2 Bf5
		35. Ra7 g6 36. Ra6+ Kc5 37. Ke1 Nf4 38. g3 Nxh3 39. Kd2 Kb5 40. Rd6 Kc5 41. Ra6
		Nf2 42. g4 Bd3 43. Re6 1/2-1/2
		'''
		
		val db = providerParser.get.parse(pgnString.charSetFromString)
		
		db.games.size.assertEquals(1)
		val game = db.games.get(0)
		game.assertNotNull
				
		85.assertEquals(game.halfMoveCount)
		7.assertEquals(game.tags.size)
		
		game.assertTag("Event", "F/S Return Match")
		game.assertTag("Site", "Belgrade, Serbia JUG")
		game.assertTag("Date", "1992.11.04")
		game.assertTag("Round", "29")
		game.assertTag("White", "Fischer, Robert J.")
		game.assertTag("Black", "Spassky, Boris V.")		
		game.assertTag("Result", "1/2-1/2")		
		game.result.assertEquals(IPGNGame.EGameResult::DRAWN)
		
		0.assertEquals(game.elements.filter(IPGNNag).size)			
		3.assertEquals(game.moves.filter[check].size)		
	}
	
	@DisplayName("Serialize Test")
	@Test
	package def testSerialize(){
					
		val db1 = providerParser.get.parseFromFileName("Test2.pgn".toResourcePath)
		db1.assertNotNull				
		val tempFile = db1.writeDB
		val db2 = tempFile.readDB
		db2.assertNotNull
		
		db1.games.size.assertEquals(db2.games.size)
	}
	
	@Disabled
	@DisplayName("Parse All Test PGNs")
	@Test
	package def void testParseAllTestPGNS(){
		val parser = providerParser.get
		parser.assertNotNull
		PGN_FILES.forEach[parser.parseFromFileName(it).assertNotNull]
	}
	
	@Disabled
	@DisplayName("Parse ECO Test")
	@Test
	package def void testParseECO(){
		providerParser.get?.parseFromFileName("ECO.pgn".toResourcePath).assertNotNull
	}
	
	
	@DisplayName("Progress Observer Test")
	@Test 
	def void testParserProgressObserver(){
		
		val file = new File("Test2.pgn".toResourcePath)		
		val fileLength = file.length		
		assertTrue(fileLength > 0, "zero length input file")
		
		val progessListener = new IParserProgressListener{
			
			var int previous = 0
			
			override onProgress(IParserProgressEvent progress){
				switch(progress.eventID){
					case IParserProgressEvent::EV_START: progress.size.assertEquals(fileLength)
					case IParserProgressEvent::EV_UPDATE: {
						assertTrue(progress.current > previous)
						assertTrue(progress.current <= fileLength)
						previous = progress.current
					}
					case IParserProgressEvent::EV_DONE: (fileLength - 2).assertEquals(previous) //minus 2 chars for the EOF
				}
			}									
		}
		val parser = providerParser.get
		parser.assertNotNull
		parser.addProgressListener(progessListener)		
		parser.parseFromFileName("Test2.pgn".toResourcePath).assertNotNull
	}
	
	
	@DisplayName("Missing Move Elements")
	@Test
	package def void testNoMoves(){			 
		
		val pgnString = 
		'''
		[Event "F/S Return Match"]
		[Site "Belgrade, Serbia JUG"]
		[Date "1992.11.04"]
		[Round "29"]
		[White "Fischer, Robert J."]
		[Black "Spassky, Boris V."]
		[Result "1/2-1/2"]
		'''
		
		//val exception = 
		assertThrows(ParseCancellationException, [providerParser.get.parse(pgnString.charSetFromString)])
	}
	
	
	@DisplayName("Multiple Period Characters")
	@Test
	package def void testMuliplePersiodChars(){
				
		val pgnString = 
		'''
		[Event "F/S Return Match"]
		[Site "Belgrade, Serbia JUG"]
		[Date "1992.11.04"]
		[Round "29"]
		[White "Fischer, Robert J."]
		[Black "Spassky, Boris V."]
		[Result "1/2-1/2"]

		1...... e4 e5 1/2-1/2
		'''
		//val exception = 
		//assertThrows(ParseCancellationException, [providerParser.get.parse(pgnString.charSetFromString)])
		val db = providerParser.get.parse(pgnString.charSetFromString)
		db.assertNotNull
		1.assertEquals(db.games.size) //one game
		2.assertEquals(db.games.get(0).elements.size) //with two elements	
	}
	
	@DisplayName("Multiple x 2 Period Characters")
	@Test
	package def void testDoubleMultiplePeriodCharaters(){
				
		val pgnString = 
		'''
		[Event "F/S Return Match"]
		[Site "Belgrade, Serbia JUG"]
		[Date "1992.11.04"]
		[Round "29"]
		[White "Fischer, Robert J."]
		[Black "Spassky, Boris V."]
		[Result "1/2-1/2"]

		1.....e4 ......................e5 1/2-1/2
		'''
		val db = providerParser.get.parse(pgnString.charSetFromString)
		db.assertNotNull
		1.assertEquals(db.games.size) //one game
		2.assertEquals(db.games.get(0).elements.size) //with two elements
	}
	
	
	@Disabled
	@DisplayName("Incorrect Move Numbers")
	@Test
	package def void testIncorrectMoveNumbers() {

		val pgnString = '''
			[Event "F/S Return Match"]
			[Site "Belgrade, Serbia JUG"]
			[Date "1992.11.04"]
			[Round "29"]
			[White "Fischer, Robert J."]
			[Black "Spassky, Boris V."]
			[Result "1/2-1/2"]
			
			1. e4 e5 3. Nf3 Nc6 1/2-1/2
		'''
		//val exception = 
		assertThrows(ParseCancellationException, [providerParser.get.parse(pgnString.charSetFromString)])

	}
	
	@Disabled
	@DisplayName("Leading Zero")
	@Test
	package def void testLeadingZero() {

		val pgnString = '''
			[Event "F/S Return Match"]
			[Site "Belgrade, Serbia JUG"]
			[Date "1992.11.04"]
			[Round "29"]
			[White "Fischer, Robert J."]
			[Black "Spassky, Boris V."]
			[Result "1/2-1/2"]
			
			01. e4 e5 3. Nf3 Nc6 1/2-1/2
		'''
		
		assertThrows(ParseCancellationException, [providerParser.get.parse(pgnString.charSetFromString)])						        
	}
	

	@DisplayName("Negative Move Number")
	@Test
	package def void testNegativeMoveNumber() {

		val pgnString = '''
			[Event "F/S Return Match"]
			[Site "Belgrade, Serbia JUG"]
			[Date "1992.11.04"]
			[Round "29"]
			[White "Fischer, Robert J."]
			[Black "Spassky, Boris V."]
			[Result "1/2-1/2"]
			
			1. e4 e5 -3. Nf3 Nc6 1/2-1/2
		'''
		
		//val exception = 
		assertThrows(ParseCancellationException, [providerParser.get.parse(pgnString.charSetFromString)])						        
	}

	
	
	def protected writeDB(IPGNDatabase db){
		val tempFile = File::createTempFile("pgn-db", ".tmp")
		val fileOut = new FileOutputStream(tempFile)
		val out = new ObjectOutputStream(fileOut)
		out.writeObject(db)
        out.close
        fileOut.close
        tempFile.path
	}
	
	def protected readDB(String fileName){
		 val fileIn = new FileInputStream(fileName)
         val in = new ObjectInputStream(fileIn)
         val object = in.readObject
         in.close
         fileIn.close
         object as IPGNDatabase
	}
	
	
	def protected charSetFromString(String string){
		val istream = new ByteArrayInputStream(string.getBytes(StandardCharsets::US_ASCII.name()))
		CharStreams::fromStream(istream)
	}
	
	def protected assertTag(IPGNTagPair tag, String name, String value){
		tag.assertNotNull
		tag.name.assertNotNull
		tag.value.assertNotNull
		tag.name.assertEquals(name)
		tag.value.assertEquals('"' + value + '"')
	}
	
	
	def protected assertTag(IPGNGame game, String name, String value){
		val tag = game.tags.findFirst[it.name == name]
		tag.assertNotNull
		tag.assertTag(name, value)
	}
	
	def void dump(IPGNDatabase db){ db.games.forEach[println(decompile)] }	
}
