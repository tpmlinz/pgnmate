package com.pgnmate.pgn.facade.module

import com.pgnmate.pgn.facade.IPGNDatabaseParser
import com.pgnmate.pgn.facade.IParserProgressListener
import com.pgnmate.pgn.PGNLexer
import com.pgnmate.pgn.PGNParser

import org.antlr.v4.runtime.CharStreams
import java.nio.charset.StandardCharsets
import org.antlr.v4.runtime.CommonTokenStream
import org.antlr.v4.runtime.tree.ParseTreeWalker
import org.antlr.v4.runtime.CharStream
import org.apache.log4j.Logger
import org.antlr.v4.runtime.Recognizer
import org.antlr.v4.runtime.misc.ParseCancellationException
import org.antlr.v4.runtime.RecognitionException
import org.antlr.v4.runtime.BaseErrorListener

package class ThrowingErrorListener extends BaseErrorListener {
	
	static val instance = new ThrowingErrorListener
   
   static def getInstance(){ instance }

   override syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e)
   throws ParseCancellationException 
   {
		throw new ParseCancellationException("line " + line + ":" + charPositionInLine + " " + msg)
   }
}

package class PGNDatabaseParser implements IPGNDatabaseParser {
	
	static val logger = Logger::getLogger(PGNDatabaseParser)
	
	var IParserProgressListener progressListener = null
	
	override parseFromFileName(String fileName) {		
		val charStream = CharStreams::fromFileName(fileName, StandardCharsets::US_ASCII)
		parse(charStream)
	}
	
	override parse(CharStream charStream){
		
		if(logger.traceEnabled){ logger.trace('''parse(«charStream»)''') }
									
		val lexer = new PGNLexer(charStream)
		//lexer.removeErrorListeners
		lexer.addErrorListener(ThrowingErrorListener::instance)
		
		val parser = new PGNParser(new CommonTokenStream(lexer))
		//parser.removeErrorListeners
		parser.addErrorListener(ThrowingErrorListener::instance)
		
		val walker = new ParseTreeWalker
		val parserListener = new PGNDatabaseParseListener
		parserListener.progressListener = progressListener
			
		val tree = parser.parse			
		walker.walk(parserListener, tree)							
		parserListener.DB
	}
	
	override setProgressListener(IParserProgressListener listener) { this.progressListener = listener }	
	override getProgressListener() { this.progressListener }
	
}