package com.pgnmate.pgntools.test

import com.google.inject.Guice
import com.pgnmate.pgntools.ApplicationModule
import org.junit.jupiter.api.BeforeAll

abstract class AbstractPGNToolTest {
	
		
	@BeforeAll
    def void setup(){
    	val injector = Guice.createInjector(new ApplicationModule)    	
    	injector.injectMembers(this)
    }
    
    static val RESOURCE_PATH = "src/test/resources"
    static def String toResourcePath(String filename){ '''«RESOURCE_PATH»/«filename»''' }
    static def String getResourcePath(){ RESOURCE_PATH }
}