package com.pgnmate.pgntools.readwrite

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.api.TestInstance.Lifecycle
import com.pgnmate.pgntools.AbstractPGNToolTest

@DisplayName("Read+Write Factory")
@TestInstance(Lifecycle.PER_CLASS)
class ReadWriteFactoryTest extends AbstractPGNToolTest{
	 
	 
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
	
	 
	 //	@Inject Provider<IPGNDatabaseParser> providerParser
	 //@Inject ICommandParser commandParser
	 	                 			
	@Test 
	def package void LoadFileTest() { 
		
		//val args = #["-i", PGN_FILES.get(0)]
		//val cmd = new CommandOptions
		//cmd.parse(args)
		
	}
	
	//ByteArrayOutputStream
	//    System.setOut(new PrintStream(new File("output-file.txt"))); - to byte stream
}
