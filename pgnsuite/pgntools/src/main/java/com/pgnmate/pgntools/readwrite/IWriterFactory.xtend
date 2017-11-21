package com.pgnmate.pgntools.readwrite

import java.util.function.Supplier

interface IWriterFactory {
	
	def IDatabaseWriter get(AbstractDatabaseFactoryKey key)
	
	def void add(AbstractDatabaseFactoryKey key, Supplier<IDatabaseWriter> factory)
	def void remove(AbstractDatabaseFactoryKey key)
}