package com.pgnmate.common

//import com.google.inject.Guice
//import org.junit.jupiter.api.BeforeAll


abstract class AbstractCommonTest {
	
	static val VALID_FEN_FILE = "validFEN.txt"	
	static val INVALID_FEN_FILE = "invalidFen.txt"
	
	static val RESOURCE_PATH = "src/test/resources"
    static def String toResourcePath(String filename){ '''«RESOURCE_PATH»/«filename»''' }
    static def String getResourcePath(){ RESOURCE_PATH }
    
    def protected String getValidFenFileName(){ VALID_FEN_FILE.toResourcePath }
    def protected String getInvalidFenFileName(){ INVALID_FEN_FILE.toResourcePath }
}