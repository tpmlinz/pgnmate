# PGN Tools
A command line interface for the [pgn-parser](https://github.com/tpmlinz/pgnmate/tree/master/pgnparser). It provides the following 
functionality

1. Parse file(s) and output to stdout
2. Parse file(s) and print report
3. Parse file(s) and reformat output

The details of the underlying parser implementation can be found at [pgn-parser](https://github.com/tpmlinz/pgnmate/tree/master/pgnparser) 
and is not repeated here but, in short, it allows a rather loose input syntax as per the PGN file import specification.  Instead 
it relies on semantic validation checks on the input allowing extra spaces, newlines, extra move number periods etc and outputting
correctly formatted PGN text (as per PGN export specification).

Just a few examples of syntactically dubious constructs are move numbers with a leading zero, e.g. <b>`01. e4 e5`</b> instead of <b>`1. e4 e5`</b> 
which although technically a bit dubious, the integers 01 are 1 are clearly the same. Other examples include multiple 
periods <b>`1.....e4 e5`</b> which again is probably not what the author intended but we can still parse this and remove 
extraneous periods.

In other cases the file may be syntactically correct but semantically invalid; the move tags do not contain all
the required information (such as the date, for example) but in all other respects the game is perfectly readable.

### <a name=print-report>Parse and Output to stdout</a>
This is the simplest of all use cases. It parses a set of (perhaps not totally compliant) PGN files given on the command line and prints 
them to stdout with correct formatting and spacing as per PGN file export specification. The default output is stdout in ascii format so no other
options are needed. To change the output format see [options](#all-options).

<b>Usage:</b> `pgntools -i file1.pgn file2.pgn` [other optional format and char-set switches here](#all-options)

### Parse and Print Report
Parse a set of files given on command line and print report detailing

1. Total number of games read
2. Number of games with syntactically dubious constructs 
3. Line and column numbers of syntactically dubious constructs
4. Line and column number of semantically invalid game annotations

<b>Usage:</b> `pgntools -i file1.pgn file2.pgn -r`
	
### Other Commands
Various other commands


1. Version <b>`pgntools -v`</b> prints version number and exits
2. Help <b>`pgntools -h`</b> prints help and exits
	

### Parse and Reformat
When format is specified then ascii file input and ascii file to stdout is assumed. This can be altered using 
the `--output` switch along with optional `--format` and `--charset` switches. Two charsets are currently supported

| name     | description       |
| -------  | ------------------|
| US-ASCII | ascii characters  |
| UTF-8    | utf-8 characeters |

Example usage:<br/>

- `pgntools -i file1.pgn file2.pgn -c=US-ASCII`
- `pgntools -i file1.pgn file2.pgn -c=UTF-8`.
- `pgntools -i file1.pgn file2.pgn -c=US-ASCII -o out.pgn -c=UTF-8`
- `pgntools -i file1.pgn file2.pgn -c=UTF-8 -o out.pgn -c=US-ASCII`

Note that charset is not needed when it is ascii as this is the default. As syntactic sugar the string `ASCII` is accepted as well as 
`US-ASCII` and is synomous. Also they are case insensitive with UTF-8 being synomous with `utf-81 for example.

### <a name=format-options>Format Options</a>
The format option `--format` or `-f` in short form specifies the storage format. The current options (case insensitive) are:

|  option    | description |
| ------     | ------------|
| STRING |  [default] plain PGN text strings |
| OBJECT |  Java serialized object format  |

Some combinations of charsets and formats probably make little sense together, such as `--format=object --charset=UTF-8` for example. 
Specifying a charset for object serialization is unclear and is simply ignored.


## <a name=all-options>All Command Options</a>
The table below shows all command line options.

| option     | description                    |
| ---------- | ------------------------------ |
| -i --input  | specify input files            |
| -o --output | specify output file            |
| -v --version | display version info |
| -h --help | display help |
| -f --format | specify file format |
| -c --charset | specify char set |
| -q -- quiet |  disable non-fatal messages |
| -d --diagnostic  |  output extra diagnostic messages |

Again, some combinations of options probably make little sense, such as `--quiet --diagnostic` requesting 
that the tool both run in quiet mode while outputting extra diagnostic messages. The exact behaviour of
these combinations is implementation defined and may vary from release to release but nothing untoward will
happen. It will either ignore one or the other (or perhaps both) or else issue a polite error message before
exiting cleanly. Suck it and see is the motto here. The combination of `-q -d` is one of the combinations 
that <i>is defined</i> and it is an error - they are mutually exclusive flags. In other cases it is not 
so clear; filters and converters are added as extensions so their exact behaviour is not yet known.

# Logging
java -Dlog4j.configuration=file:///.../resources/log4j.properties -jar target/pgntools-0.0.1-SNAPSHOT.jar  -i src/test/resources/Test1.pgn -charset=US_ASCII

# Charset = US-ASCII not US_ASCII

1. US-ASCII
2. UTF-8
3. UTF-16
4. ISO-8859-1
5. UTF-16BE
6. UTF-16LE

