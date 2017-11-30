package com.pgnmate.pgnparser.facade

import com.pgnmate.pgnparser.pgnnode.IPGNDatabase
import com.pgnmate.pgnparser.pgnnode.IPGNGame
import com.pgnmate.pgnparser.pgnnode.IPGNMove
import com.pgnmate.pgnparser.pgnnode.IPGNNag
import com.pgnmate.pgnparser.pgnnode.IPGNNode
import com.pgnmate.pgnparser.pgnnode.IPGNTagPair
import com.pgnmate.pgnparser.pgnnode.IPGNVariation
import com.pgnmate.common.chess.identifiers.PGNMoveSuffix

class PGNUtils {
	
	static dispatch def CharSequence decompile(IPGNDatabase it){
		'''«games.map[decompile].join('\n\n')»'''		
	}
	
	static dispatch def CharSequence decompile(IPGNGame it){
		'''«tags.map[decompile].join('\n')»«'\n\n'»«elements.map[decompile].join(' ')»'''
	}	
	
	static dispatch def CharSequence decompile(IPGNMove it){
		'''«moveInicator.moveNumberText»«SAN»'''
	}	
	
	static dispatch def CharSequence decompile(IPGNTagPair it){
		'''[«name» «value»]'''	
	}
	
	static dispatch def CharSequence decompile(PGNMoveSuffix suffix){
		'''«suffix.suffixText»'''	
	}
	
	static dispatch def CharSequence decompile(IPGNVariation it){
		'''(«elements.map[decompile].join(' ')»)'''
	}
	
	static dispatch def CharSequence decompile(IPGNNag it){
		'''$«value»'''		
	}
	
	static dispatch def CharSequence decompile(IPGNNode node){
		'''unknown node «node»'''	
	}
	static dispatch def CharSequence decompile(Object object){
		'''unknown object «object»'''	
	}	
	
	static dispatch def CharSequence decompile(Void v){
		'''null'''	
	}
	
	static private def CharSequence suffixText(PGNMoveSuffix suffix){ suffix?.toSanText() ?: "" }
	static private def CharSequence moveNumberText(int value){ if(value != -1) value.toString + "." else "" }
}