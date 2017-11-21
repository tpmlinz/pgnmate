package com.pgnmate.pgntools.readwrite

import java.util.function.Supplier

interface IReaderFactory {
	
	def IDatabaseReader get(AbstractDatabaseFactoryKey key)
	
	def void add(AbstractDatabaseFactoryKey key, Supplier<IDatabaseReader> factory)
	def void remove(AbstractDatabaseFactoryKey key)
	
}