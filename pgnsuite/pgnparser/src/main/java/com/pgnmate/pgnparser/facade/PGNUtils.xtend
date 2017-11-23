package com.pgnmate.pgnparser.facade

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
	
	static dispatch def CharSequence decompile(ESuffix suffix){
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
	
	static private def CharSequence suffixText(ESuffix suffix){ suffix?.getText() ?: "" }
	static private def CharSequence moveNumberText(int value){ if(value != -1) value.toString + "." else "" }
}