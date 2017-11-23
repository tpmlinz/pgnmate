package com.pgnmate.pgntools.readwrite

import java.util.function.Supplier


/**
 * Database reader factory creates readers for various format types
 */
interface IReaderFactory {
	
	/**
	 * @param key for reader
	 * @return reader for key or <code>null</null> on failure
	 */
	def IDatabaseReader get(AbstractDatabaseFactoryKey key)
	
	/**
	 * Add factory method for key
	 * @param key of factory method
	 * @param factory method for reader
	 */
	def void add(AbstractDatabaseFactoryKey key, Supplier<IDatabaseReader> factory)
	
	/**
	 * Remove previously added factory method
	 * @param key of factory method to remove
	 */
	def void remove(AbstractDatabaseFactoryKey key)
	
}