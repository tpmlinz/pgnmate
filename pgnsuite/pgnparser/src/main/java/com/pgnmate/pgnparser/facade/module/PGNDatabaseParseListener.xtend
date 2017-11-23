package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgn.PGNBaseListener
import com.pgnmate.pgn.PGNParser
import com.pgnmate.pgnparser.facade.ESuffix
import com.pgnmate.pgnparser.facade.IPGNDatabase
import com.pgnmate.pgnparser.facade.IPGNGame.EGameResult
import com.pgnmate.pgnparser.facade.IPGNNode
import com.pgnmate.pgnparser.facade.IPGNValidator
import com.pgnmate.pgnparser.facade.IPGNVariation
import com.pgnmate.pgnparser.facade.IParserProgressEvent
import com.pgnmate.pgnparser.facade.IParserProgressListener
import com.pgnmate.pgnparser.facade.PGNFactory
import java.util.ArrayDeque
import java.util.Collection
import org.antlr.v4.runtime.ParserRuleContext
import org.antlr.v4.runtime.misc.ParseCancellationException
import org.antlr.v4.runtime.tree.ErrorNode
import org.apache.log4j.Logger

package class PGNDatabaseParseListener extends PGNBaseListener{
		
	static val logger = Logger::getLogger(PGNDatabaseParseListener)		
	
	/*
	 * FIXME - dummy validator placeholder
	 */
	val validator = new IPGNValidator{	override validate(IPGNNode node, Object ctx) {}	}
	
	var int dbSize	
	
	static class ParserProgressEvent  implements IParserProgressEvent{		
		val int event
		val int current
		val int size
				
		new(int event, int current, int size){ this.event = event this.current = current this.size = size }	
		override int getCurrent(){ current }
		override int getSize(){ size }
		override getEventID(){ event }	
	}
	
	
	var IPGNDatabase db
	def getDB(){ db }
	
	var Collection<IParserProgressListener> progressListeners
	
	def getProgressListeners(){ progressListeners }	
	def void setProgressListeners(Collection<IParserProgressListener> listeners){ progressListeners = listeners }		
	def private notifyProgress(int event, int current, int size){
		if(!progressListeners.nullOrEmpty){ 
			val arg = new ParserProgressEvent(event, current, dbSize)
			progressListeners.forEach[onProgress(arg)]
		}
	}
	
		
	val variationStack = new ArrayDeque<IPGNVariation>
	
	
	override enterPgn_database(PGNParser.Pgn_databaseContext ctx) { 
		
		logger.trace(['''enterPgn_database(«ctx.toDebugString»)'''])
		dbSize = ctx.start.inputStream.size			
		notifyProgress(IParserProgressEvent::EV_START, ctx.start.startIndex, dbSize)
		
		db = PGNFactory::instance.createDatabase
		validator.validate(db, ctx) //FIXME - when to call validator - before or after adding to node model
	}
	
	override exitPgn_database(PGNParser.Pgn_databaseContext ctx){
		logger.trace(['''exitPgn_database(«ctx.toDebugString»)'''])
		notifyProgress(IParserProgressEvent::EV_DONE, ctx.stop.stopIndex, dbSize)		
	}
	
	override enterPgn_game(PGNParser.Pgn_gameContext ctx){
		
		logger.trace(['''enterPgn_game(«ctx.toDebugString»)'''])								
							
		val game = PGNFactory::instance.createGame
		validator.validate(game, ctx) //FIXME - when to call validator - before or after adding to node model
		db.games.add(game)				
	}
	
	override exitPgn_game(PGNParser.Pgn_gameContext ctx){
		logger.trace(['''exitPgn_game(«ctx.toDebugString»)'''])										
		notifyProgress(IParserProgressEvent::EV_UPDATE, ctx.stop.stopIndex, dbSize)
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







