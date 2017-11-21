package com.pgnmate.pgn.facade.module


import com.pgnmate.pgn.facade.ESuffix
import com.pgnmate.pgn.facade.IObservableParserProgress
import com.pgnmate.pgn.facade.IPGNDatabase
import com.pgnmate.pgn.facade.IPGNGame.EGameResult
import com.pgnmate.pgn.facade.IPGNNode
import com.pgnmate.pgn.facade.IPGNValidator
import com.pgnmate.pgn.facade.IPGNVariation
import com.pgnmate.pgn.facade.IParserProgressListener
import com.pgnmate.pgn.facade.PGNFactory
import java.util.ArrayDeque
import org.antlr.v4.runtime.ParserRuleContext
import org.antlr.v4.runtime.misc.ParseCancellationException
import org.apache.log4j.Logger
import com.pgnmate.pgn.PGNBaseListener
import com.pgnmate.pgn.PGNParser
import org.antlr.v4.runtime.tree.ErrorNode

package class PGNDatabaseParseListener extends PGNBaseListener implements IObservableParserProgress{
		
	static val logger = Logger::getLogger(PGNDatabaseParseListener)		
	
	/*
	 * FIXME - dummy validator placeholder
	 */
	val validator = new IPGNValidator{	override validate(IPGNNode node, Object ctx) {}	}
	
	
	var IPGNDatabase db
	def getDB(){ db }
	
		
	val variationStack = new ArrayDeque<IPGNVariation>
		
	// ---------------------------------
	// Progress listener implementation
	var IParserProgressListener progessListener = null						
	override setProgressListener(IParserProgressListener listener) { this.progessListener = listener }	
	override IParserProgressListener getProgressListener() { this.progessListener }
	//----------------------------------			
	
	override enterPgn_database(PGNParser.Pgn_databaseContext ctx) { 
		
		logger.trace(['''enterPgn_database(«ctx.toDebugString»)'''])
				
		progessListener?.start(ctx.start.inputStream.size)
		
		db = PGNFactory::instance.createDatabase
		validator.validate(db, ctx) //FIXME - when to call validator - before or after adding to node model
	}
	
	override exitPgn_database(PGNParser.Pgn_databaseContext ctx){
		logger.trace(['''exitPgn_database(«ctx.toDebugString»)'''])			
		progessListener?.end()
	}
	
	override enterPgn_game(PGNParser.Pgn_gameContext ctx){
		
		logger.trace(['''enterPgn_game(«ctx.toDebugString»)'''])								
							
		val game = PGNFactory::instance.createGame
		validator.validate(game, ctx) //FIXME - when to call validator - before or after adding to node model
		db.games.add(game)				
	}
	
	override exitPgn_game(PGNParser.Pgn_gameContext ctx){
		logger.trace(['''exitPgn_game(«ctx.toDebugString»)'''])										
		progessListener?.progress(ctx.stop.getStopIndex)
	}
	
	override enterTag_pair(PGNParser.Tag_pairContext ctx){
		val tagPair = PGNFactory::instance.createTagPair
		validator.validate(tagPair, ctx) //FIXME - when to call validator - before or after adding to node model
		tagPair.name = ctx.tag_name.text
		tagPair.value = ctx.tag_value.text
		db.games.last.tags.add(tagPair)
	}
			
	override enterGame_termination(PGNParser.Game_terminationContext ctx){
		
		logger.trace(['''enterGame_termination(«ctx.toDebugString»)'''])		
		
		
		db.games.last.gameResult =
		if(ctx.WHITE_WINS !== null)	EGameResult::WHITE_WINS	
		else if(ctx.BLACK_WINS !== null) EGameResult::BLACK_WINS
		else if(ctx.DRAWN_GAME !== null) EGameResult::DRAWN
		else if(ctx.ASTERISK !== null) EGameResult::ASTERISK
		else throw new IllegalArgumentException
		
		validator.validate(db.games.last, ctx) //FIXME - when to call validator - before or after adding to node model		
		
	}
	
	override exitGame_termination(PGNParser.Game_terminationContext ctx){
		logger.trace(['''exitGame_termination(«ctx.toDebugString»)'''])				
	}
	
	
	override enterMove_element(PGNParser.Move_elementContext ctx) {
		
		logger.trace(['''enterMove_element(«ctx.toDebugString»)'''])		
		
		val move = PGNFactory::instance.createMove
		//move.context = ctx
		move.SAN = ctx.san_move.text
		
		val moveNumberText = ctx?.INTEGER?.text
		
		//TODO - should really use semantic validator for checking leading zero
		if(!moveNumberText.nullOrEmpty){
			
			val firstChar = moveNumberText.charAt(0)
			if(firstChar == '0'){			
				logger.warn(['''line «ctx.start.line»: «ctx.start.charPositionInLine» Move number has leading zero'''])			
			}							
			move.moveInicator = Integer::parseInt(ctx.INTEGER.text)
			if(move.moveInicator < 0){
				val msg = '''line «ctx.start.line»: «ctx.start.charPositionInLine» Move number has leading zero'''
				logger.error(msg)
				throw new ParseCancellationException(msg)
			}
			
			//FIXME - use semantic validator for sequential numbering check	
		}
		
		if(ctx?.SUFFIX_ANNOTATION?.text !== null)
			move.suffix = ESuffix::fromString(ctx.SUFFIX_ANNOTATION.text)
			
		validator.validate(move, ctx) //FIXME - when to call validator - before or after adding to node model		
			
		val elements = variationStack?.peek?.elements ?: db.games.last.elements				
		elements.add(move)
		
	}
	
	override exitMove_element(PGNParser.Move_elementContext ctx) {
		logger.trace(['''exitMove_element(«ctx.toDebugString»)'''])				
	}
	
	//FIXME - variations now children of move
	override enterRecursive_variation(PGNParser.Recursive_variationContext ctx) {
		
		logger.trace(['''enterRecursive_variation(«ctx.toDebugString»)'''])		
		
		val newVariation = PGNFactory::instance.createVariation
		validator.validate(newVariation, ctx) //FIXME - when to call validator - before or after adding to node model
		val elements = variationStack?.peek?.elements ?: db.games.last.elements	
		elements.add(newVariation)					
		variationStack.push(newVariation)
	}
	
	override exitRecursive_variation(PGNParser.Recursive_variationContext ctx) {
		logger.trace(['''exitRecursive_variation(«ctx.toDebugString»)'''])				
		variationStack.pop
	}			
	
	override visitErrorNode(ErrorNode node){
		
	}
	
	def private String toDebugString(ParserRuleContext ctx){ ctx.toString }
}







