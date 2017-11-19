package com.pgnmate.pgn.test


import com.pgnmate.pgn.facade.module.PGNParserModule
import com.google.inject.Guice
import org.junit.jupiter.api.BeforeAll

abstract class AbstractParserTest {
	
	val protected injector = Guice.createInjector(new PGNParserModule)
    
    @BeforeAll
    def void setup(){
    	injector.injectMembers(this)
    }
    
    static val RESOURCE_PATH = "src/test/resources"
    static def String toResourcePath(String filename){ '''«RESOURCE_PATH»/«filename»''' }
    static def String getResourcePath(){ RESOURCE_PATH }
}