package com.pgnmate.pgntools.readwrite

import com.google.inject.AbstractModule

class ReadWriteModule extends AbstractModule {
	
	override protected configure() {
		bind(IReaderFactory).to(ReaderFactory)
		bind(IWriterFactory).to(WriterFactory)
		bind(DefaultDatabaseWriter)
		bind(DefaultDatabaseReader)
	}	
}