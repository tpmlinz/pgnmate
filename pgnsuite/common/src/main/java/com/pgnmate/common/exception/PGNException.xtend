package com.pgnmate.common.exception

import java.lang.Exception

/**
 * Superclass of all PGN suite exceptions
 */
abstract class PGNException extends Exception {	
	new(){}
	new(Exception ex){ super(ex) }
	new(String message){ super(message) }
	new(String message, Throwable cause){ super(message, cause) }
}
