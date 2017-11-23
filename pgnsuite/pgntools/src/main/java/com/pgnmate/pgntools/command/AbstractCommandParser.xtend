package com.pgnmate.pgntools.command

import com.google.inject.Inject
import com.google.inject.Provider
import com.pgnmate.pgnparser.facade.IPGNDatabase
import com.pgnmate.pgntools.Main
import com.pgnmate.pgntools.readwrite.DatabaseFactoryKey
import com.pgnmate.pgntools.readwrite.IReaderFactory
import com.pgnmate.pgntools.readwrite.IWriterFactory
import java.util.Map
import org.apache.commons.cli.CommandLine
import org.apache.commons.cli.DefaultParser
import org.apache.commons.cli.HelpFormatter
import org.apache.commons.cli.Option
import org.apache.commons.cli.OptionGroup
import org.apache.commons.cli.Options
import org.apache.commons.cli.ParseException
import org.apache.log4j.Logger

/**
 * Parses command line arguments
 */
abstract class AbstractCommandParser implements ICommandParser{		
	
	static val logger = Logger::getLogger(AbstractCommandParser)
	
	@Inject Provider<IPGNDatabase> databaseProvider
	@Inject IReaderFactory readerFactory
	@Inject IWriterFactory writerFactory
		
	var Map<String, Option> optionMap
	var Options optionsCache
	
	public static var INPUT = "input"
	public static val OUTPUT = "output"
	public static val QUIET = "quiet"
	public static val DIAGNOSTIC = "diagnostic"
	public static val REPORT = "report"
	public static val FORMAT = "format"
	public static val CHARSET = "charset"
	public static val VERSION = "version"
	public static val HELP = "help"
	
	
	var Verbosity verbosity = Verbosity::NORMAL	
	protected def getVerbosity(){ verbosity }
	protected def void setVerbosity(Verbosity value){ verbosity = value }
	
	/*
	 * Utility class (data structure) to hold parser result
	 */
	static class ParserOutput{
		public val inputFiles = <String>newArrayList
		public var String outputFile
		public var inputFormatSpecifiers = <String>newArrayList(null,null) //[format, charset]
		public var outputFormatSpecifiers =  <String>newArrayList(null,null) //[Format, Charset]
		public var CommandLine commandLine
		public val String[] originalArgs		
		new(String[] originalArgs){ this.originalArgs = originalArgs }
	}
	
	
	static class FileFormatParser{
		
		var String format
		var String charset
		
		def void parse(String[] args){

			val options = #[
				Option::builder("f").longOpt("format" ).desc("data format" ).hasArg.numberOfArgs(1).valueSeparator('=').argName("format").build,
				Option::builder("c").longOpt("charset" ).desc("character set" ).hasArg.numberOfArgs(1).valueSeparator('=').argName("charset").build
			].createOptions
						
			val parser = new DefaultParser
			var CommandLine commandLine			
					
			commandLine = parser.parse(options, args)
			if(!commandLine.argList.empty){ throw new ParseException('''extraneous args «commandLine.argList.join(', ')»''') }
			val fc = commandLine.iterator.filter[id == 'f'.charAt(0)].size
			if(fc > 0) { throw new ParseException('--format option may only appear once') }
			val cc = commandLine.iterator.filter[id == 'c'.charAt(0)].size
			if(cc > 0) { throw new ParseException('--charset option may only appear once') }								
			
			format = commandLine.iterator.filter[id == 'f'.charAt(0)]?.head?.value
			charset = commandLine.iterator.filter[id == 'c'.charAt(0)]?.head?.value
		}
	}
	

	protected var ParserOutput parserOutput 

	
	/**
	 * Parses command line arguments to find reader and writer
	 * @param args to parse
	 */
	override parse(String[] args){
		
		parserOutput = new ParserOutput(args)	// data struture for result		
		buildOptions							//build the command line options
		
		parserOutput.commandLine = getCommandLine(args)
		if(parserOutput.commandLine === null){ System.exit(-1) }
		
		//command line parsed so process the boolean flags
		conditionalActionAndExit([parserOutput.commandLine.hasOption('h')], [showHelp], 0)
		conditionalActionAndExit([parserOutput.commandLine.hasOption('v')], [showVersion], 0)						
		conditionalAction([parserOutput.commandLine.hasOption('q')], [verbosity = Verbosity::QUIET])
		conditionalAction([parserOutput.commandLine.hasOption('d')], [verbosity = Verbosity::DIAGNOSTIC])
						
		// Warn about multiple boolean flags
		 if(parserOutput.commandLine.occurrencesOf('q') > 1){ warn('warning: multiple occurrences of -q option') }
		 if(parserOutput.commandLine.occurrencesOf('d') > 1){ warn('warning: multiple occurrences of -d option')}		 					
		
		// input and output files and their format specifiers.
		parseInputFiles
		conditionalActionAndExit([parserOutput.inputFiles.isNullOrEmpty], [error('''no inputs specified''')], -1)
					
		parseOutputFile // no check - output can be null for stdout		
		
		//parserOutput.debugDump
		
		val readerKey = new DatabaseFactoryKey(parserOutput.inputFormatSpecifiers.get(0), parserOutput.inputFormatSpecifiers.get(1))		
		val reader = readerFactory.get(readerKey)
		conditionalActionAndExit([reader === null], [error('''no reader found''')], -1)
						
		val writerKey = new DatabaseFactoryKey(parserOutput.outputFormatSpecifiers.get(0), parserOutput.outputFormatSpecifiers.get(1))
		val writer = writerFactory.get(writerKey)
		conditionalActionAndExit([writer === null], [error('''no writer found''')], -1)
					
		val masterDB = databaseProvider.get //cappo di tutti cappi
		
		// try to read each file and add to master DB
		parserOutput.inputFiles.forEach[
			try{
				val db = reader.read(it)
				masterDB.games.addAll(db.games)				
			}
			catch(ParseException ex){
				logger.error(ex.message)
				error(ex.message)	
			}
		]
		
		// write master DB
		try{
			writer.write(masterDB)
		}
		catch(ParseException ex){
			logger.error(ex.message)
			error(ex.message)
			System.exit(-1)
		}
		
	}// end parse method
	
	
	def protected conditionalAction(() => Boolean condition, () => void action){ if(condition.apply) action.apply }
	
	def protected conditionalActionAndExit(() => Boolean condition, () => void action, int code ){ 
		if(condition.apply){			
			action.apply
			System.exit(code)			
		}
	}
	
	
	
	def protected buildOptions(){ allOptions }	
	def protected Options getAllOptions(){
		
		if(optionMap === null){ 
			
			optionMap = #{
				QUIET -> Option::builder(Verbosity::QUIET.shortOpt).longOpt(Verbosity::QUIET.longOpt).desc(Verbosity::QUIET.description).build,
				DIAGNOSTIC-> Option::builder(Verbosity::DIAGNOSTIC.shortOpt).longOpt(Verbosity::DIAGNOSTIC.longOpt).desc(Verbosity::DIAGNOSTIC.description).build,
				INPUT -> Option::builder("i").longOpt("input" ).desc("pgn input source" ).hasArgs.argName("files [FMT] [CHARSET]").build,
				OUTPUT -> Option::builder("o").longOpt("output" ).desc("pgn output target" ).hasArgs.argName("file [FMT] [CHARSET]").build,
				HELP -> Option::builder("h").longOpt("help" ).desc("print this message and exit").build,
				VERSION -> Option::builder("v").longOpt("version" ).desc("print version info and exit").build,
				
				//FORMAT -> Option::builder("f").longOpt("format" ).desc("data format" ).hasArg.numberOfArgs(1).valueSeparator('=').argName("format").build,
				//CHARSET -> Option::builder("c").longOpt("charset" ).desc("character set" ).hasArg.numberOfArgs(1).valueSeparator('=').argName("charset").build,
				REPORT -> Option::builder("r").longOpt("report" ).desc("report" ).hasArg.numberOfArgs(1).valueSeparator('=').argName("report").build
			}									
			optionsCache = new Options
			optionsCache.add(optionMap.values.filter[!#['q'.charAt(0), 'd'.charAt(0)].contains(id)])		
			val verbosityGroup = new OptionGroup
			verbosityGroup.addOption(optionMap.get(QUIET))		
			verbosityGroup.addOption(optionMap.get(DIAGNOSTIC))	
			optionsCache.addOptionGroup(verbosityGroup)										
		}								
		optionsCache
	}
	
	
	
	def protected getCommandLine(String[] args){
			
		var CommandLine commandLine = null										
		try{
			val parser = new DefaultParser			
			commandLine = parser.parse(getAllOptions, args)	
		}
		catch(ParseException ex){
			error(ex.message)
			System.exit(-1)
		}
		if(!commandLine.argList.empty){
			error('''extraneous arguments [«commandLine.argList.join(', ')»]''')
			System.exit(-1)
		}
		commandLine
	}
	
	
	def protected String getVersion(){ Main::VERSION }		
	def protected void showVersion(){ println('''pgntools version «version»''') }
	
	def protected void showHelp(){		
		val formatter = new HelpFormatter 		 		
		formatter.printHelp("pgntools", helpHeader, allOptions, helpFooter, true)
	}
		
	
	def protected void parseInputFiles(){
		
		val count = parserOutput.commandLine.occurrencesOf('i')
		if(count > 1){ throw new ParseException('option --i  may occur at most once') }
		
		val files = parserOutput.commandLine.getOptionValues('i').filter[!startsWith('-')]
		if(files.empty){ throw new ParseException('no input files specified') }
		parserOutput.inputFiles.addAll(files)				
				
		val switches = parserOutput.commandLine.getOptionValues('i').filter[startsWith('-')]
		if(!switches.empty){
			val formatParser = new FileFormatParser
			formatParser.parse(switches)		
			parserOutput.inputFormatSpecifiers.clear
			parserOutput.inputFormatSpecifiers.addAll(formatParser.format, formatParser.charset)
		}
	}
	
	def protected void parseOutputFile(){ 
		
		val count = parserOutput.commandLine.occurrencesOf('o')
		if(count == 0){ return }		
		if(count > 1){ throw new ParseException('option --o  may occur at most once') }
		
		val files = parserOutput.commandLine.getOptionValues('o').filter[!startsWith('-')]
		if(files.size > 1 ){ throw new ParseException('too many output files specified') }
		parserOutput.outputFile = files.head					
		
		val switches = parserOutput.commandLine.getOptionValues('o').filter[startsWith('-')]
		if(!switches.empty){
			val formatParser = new FileFormatParser
			formatParser.parse(switches)	
			parserOutput.outputFormatSpecifiers.clear
			parserOutput.outputFormatSpecifiers.addAll(formatParser.format, formatParser.charset)	
		}		
	}	
	
	
	
	def private debugDump(ParserOutput po){
		
		println('command line output')
		po.commandLine.options.forEach[println('''option: «longOpt»: values: «values.join(', ')»''')]
		println('''input files: «po.inputFiles.join(', ')»''')
		println('''input spec: [«po.inputFormatSpecifiers.get(0)», «po.inputFormatSpecifiers.get(1)»]''')		
		println('''output file: «po.outputFile»''')
		println('''output spec: [«po.outputFormatSpecifiers.get(0)», «po.outputFormatSpecifiers.get(1)»]''')
	}
	
	
	def protected warn(Object object){ if(verbosity != QUIET) System.err.println(object) }
	def protected error(Object object){ if(verbosity != QUIET) System.err.println(object) }
	//def protected stderr(Object object){ System.err.println(object) }
	
	def protected int occurrencesOf(CommandLine cmd, char charID){ cmd.iterator.filter[id == charID].size }	
	def protected String getHelpHeader(){ '''pgntools version «version»'''}
	def protected String getHelpFooter(){ "Please report any issues to pgntools" }				
	static def protected Options add(Options options, Iterable<Option> items){ items.forEach[options.addOption(it)] options}
	static def protected Options createOptions(Iterable<Option> items){ val options = new Options options.add(items) }

}