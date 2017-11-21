# PGN Parser
An Java library based on an antlr parser for processing chess PGN [(Portable Game Notation)](https://en.wikipedia.org/wiki/Portable_Game_Notation) files. 
Its function and goal is to read PGN files and create an in-memory representation as plain old java objects (POJOs).

It does not

1. Play chess
2. Understand chess
3. Make moves
4. Have notions of <i>piece</i> or <i>chess position</i>

In short, it is concerned with PGN syntax and semantics in an attempt to comply with the rather ill-defined PGN syntax. Given a reasonably well-formed
PGN file consisting of one or more game elements it creates a hierarchical structure of java objects representing the PGN abstract syntax tree (AST).

