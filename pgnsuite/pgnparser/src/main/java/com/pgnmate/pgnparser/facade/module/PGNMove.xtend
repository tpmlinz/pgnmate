package com.pgnmate.pgnparser.facade.module

import com.pgnmate.pgnparser.facade.IPGNMove
import com.pgnmate.pgnparser.facade.ESuffix
import com.pgnmate.pgnparser.facade.ECastling

package class PGNMove extends AbstractPGNNode implements IPGNMove {
	
	static final long serialVersionUID = 1L				
	
	var ESuffix suffix = null
	var int moveIndicator = -1
	var String SAN
	
	package new(){}
	
	override getSuffix() { this.suffix }	
	override setSuffix(ESuffix suffix) { this.suffix = suffix }	
	override setSuffix(String symbol) { this.suffix = ESuffix::fromString(symbol) }	
	override removeSuffix() { suffix = null }
	
	override isCheck() { !SAN.nullOrEmpty && SAN.contains('+')  }
	override isMate(){ !SAN.nullOrEmpty && SAN.contains('#')  }
	
	override isCapture() { !SAN.nullOrEmpty && SAN.contains('#') }
	
	override getMoveInicator() { moveIndicator }	
	override setMoveInicator(int value) { this.moveIndicator = value }	
	override clearMoveInicator() { moveIndicator = -1 }
	
	override getSAN() { SAN }	
	override setSAN(String value) { SAN = value }
	
	override getCastling() { 
		var ECastling result = null
		if(!SAN.nullOrEmpty){
			if(SAN.startsWith(ECastling::KINGSIDE.santText))
				result = ECastling::KINGSIDE
			else if(SAN.startsWith(ECastling::QUEENSIDE.santText))
				result = ECastling::QUEENSIDE			
		}
		result	
	}
	
	override isCastling() { getCastling !== null }
	
	
	
	override getChildren(){ emptyList }				
	
		
}