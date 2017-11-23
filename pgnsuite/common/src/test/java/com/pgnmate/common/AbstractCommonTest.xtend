package com.pgnmate.common

//import com.google.inject.Guice
//import org.junit.jupiter.api.BeforeAll


abstract class AbstractCommonTest {
	
	static val RESOURCE_PATH = "src/test/resources"
    static def String toResourcePath(String filename){ '''«RESOURCE_PATH»/«filename»''' }
    static def String getResourcePath(){ RESOURCE_PATH }
}