package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.facade.module.PGNParserModule
import com.google.inject.Guice
import com.google.inject.Inject
import com.google.inject.Injector
import com.google.inject.Provider
import com.pgnmate.pgnparser.pgnnode.IPGNDatabase
import com.pgnmate.pgnparser.pgnnode.IPGNGame
import com.pgnmate.pgnparser.pgnnode.IPGNVariation
import com.pgnmate.pgnparser.pgnnode.IPGNTagPair
import com.pgnmate.pgnparser.pgnnode.IPGNMove
import com.pgnmate.pgnparser.pgnnode.IPGNNag

class PGNFactory {
	
	static var PGNFactory instance	
	var Injector injector
	
	@Inject Provider<IPGNDatabase> providerDB
	@Inject Provider<IPGNGame> providerGame
	@Inject Provider<IPGNNag> providerNAG
	@Inject Provider<IPGNTagPair> providerTagPair
	@Inject Provider<IPGNMove> providerMove
	@Inject Provider<IPGNVariation> providerVariation
	@Inject Provider<IPGNDatabaseParser> providerParser
	
	private new(){
		injector = Guice::createInjector(new PGNParserModule)
		injector.injectMembers(this)					
	}
	
	def static PGNFactory getInstance(){ instance ?: (instance = new PGNFactory) }	
	def createDatabase(){ providerDB.get }
	def createGame(){ providerGame.get }
	def createNAG(){ providerNAG.get }
	def createTagPair(){ providerTagPair.get }
	def createMove(){ providerMove.get }
	def createVariation(){ providerVariation.get }
	def createParser(){ providerParser.get }
}