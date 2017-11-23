package com.pgnmate.pgntools.readwrite

import java.util.function.Supplier

/**
 * Creates pgn writers for different formats
 */
interface IWriterFactory {
	
	/**
	 * Return write for key or <code>null</code> on failure
	 * @param key for writer
	 */
	def IDatabaseWriter get(AbstractDatabaseFactoryKey key)
	
	/**
	 * Add factory method for key
	 * @param key for factory method
	 * @param factory method for writer
	 */
	def void add(AbstractDatabaseFactoryKey key, Supplier<IDatabaseWriter> factory)
	def void remove(AbstractDatabaseFactoryKey key)
}