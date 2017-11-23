package com.pgnmate.pgntools.readwrite

import org.apache.commons.lang3.ObjectUtils
import java.nio.charset.Charset
import java.nio.charset.StandardCharsets
import org.apache.log4j.Logger


/**
 * A factory key is used to find factory methods for readers and writers. It has two values
 * <ul>
 * <li>format - user defined file format</ii>
 * <li>charset - character set for reading or writing</li>
 * </ul>
 */
abstract class AbstractDatabaseFactoryKey{
	
	static val logger = Logger::getLogger(AbstractDatabaseFactoryKey)		
	
	static private int MAGIC_NUMBER = 53
	
	val String format
	val Charset charset
	
	/**
	 * @param format for reador write
	 * @parameter charsetName the canonical name of the character set
	 */
	new(String format, String charsetName){
		this.format = format
		this.charset = createCharset(charsetName)
	}

	/**
	 * Equality test allowing <code>null</code> format strings to match empty format strings 
	 * @param other object to test
	 * @return true on equality otherwise false
	 */
	override equals(Object other) {	
									
		if(!(other instanceof AbstractDatabaseFactoryKey)){ return false }							
		val otherKey = other as AbstractDatabaseFactoryKey
		format.stringEquivalence(otherKey.format) && charset == otherKey.charset
	}
	
	/**
	 * Return hashCode to match equals method
	 * @return hash value
	 */
	override hashCode() { MAGIC_NUMBER * format.formatHash + ObjectUtils.hashCode(charset) }
	
	/**
	 * Return human readable formatted string used for debug and user feedback
	 * @return key as formatted string
	 */
	override toString(){
		val fmt = if(format.nullOrEmpty) 'null' else format
		val cst = if(charset === null) 'null' else charset.name
		'''format = «fmt», charset = «cst»'''
	}
	
	def private boolean stringEquivalence(String a, String b){(a.nullOrEmpty && b.nullOrEmpty) || (a == b) }
	def private int formatHash(String string){ if(string.nullOrEmpty) 0 else string.hashCode }
	
	/**
	 * Return format
	 */
	def final String getFormat(){ format }
	
	/**
	 * Return charset
	 */
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
