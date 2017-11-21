package com.pgnmate.pgntools.readwrite

import org.apache.commons.lang3.ObjectUtils
import java.nio.charset.Charset
import java.nio.charset.StandardCharsets
import org.apache.log4j.Logger

abstract class AbstractDatabaseFactoryKey{
	
	static val logger = Logger::getLogger(AbstractDatabaseFactoryKey)		
	
	static private int MAGIC_NUMBER = 53
	
	val String format
	val Charset charset
	
	new(String format, String charsetName){
		this.format = format
		this.charset = createCharset(charsetName)
	}

	override equals(Object other) {	
									
		if(!(other instanceof AbstractDatabaseFactoryKey)){ return false }							
		val otherKey = other as AbstractDatabaseFactoryKey
		format.stringEquivalence(otherKey.format) && charset == otherKey.charset
	}
	
	override hashCode() { MAGIC_NUMBER * format.formatHash + ObjectUtils.hashCode(charset) }
	
	override toString(){
		val fmt = if(format.nullOrEmpty) 'null' else format
		val cst = if(charset === null) 'null' else charset.name
		'''format = «fmt», charset = «cst»'''
	}
	
	def private boolean stringEquivalence(String a, String b){(a.nullOrEmpty && b.nullOrEmpty) || (a == b) }
	def private int formatHash(String string){ if(string.nullOrEmpty) 0 else string.hashCode }
	
	def final String getFormat(){ format }
	def final Charset getCharset(){ charset }
				
	static protected def Charset createCharset(String str){
		var Charset result
		if(!str.nullOrEmpty){ 
			result = Charset::forName(str)
			if(result === null){ logger.error('''failed to get charset «str» using default''') }
		}
		if(result === null){
			if(logger.traceEnabled){ logger.trace('''getting default US_ASCII charset''')}
			result = StandardCharsets::US_ASCII			
		}
		if(result === null){
			val msg = 'failed to find Charset'
			logger.fatal(msg)
			throw new IllegalStateException(msg)
		}
		result
	}
}
