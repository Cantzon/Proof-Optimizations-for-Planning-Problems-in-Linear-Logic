all: 	
	ocamllex lispLexerLLTP.mll     
	ocamlyacc lispParserLLTP.mly
	ocamlc -c lispParserLLTP.mli
	ocamlc -c lispLexerLLTP.ml
	ocamlc -c lispParserLLTP.ml
	ocamlc -c main.ml
	ocamlc -o main lispLexerLLTP.cmo lispParserLLTP.cmo main.cmo