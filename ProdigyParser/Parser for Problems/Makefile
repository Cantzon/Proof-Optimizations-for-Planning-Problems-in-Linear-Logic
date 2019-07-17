all: 	
	ocamllex lispLexerLLTP.mll     
	ocamlyacc lispParserLLTP.mly
	ocamlc -c lispParserLLTP.mli
	ocamlc -c lispLexerLLTP.ml
	ocamlc -c lispParserLLTP.ml
	ocamlc -c main.ml
	ocamlc -o main lispLexerLLTP.cmo lispParserLLTP.cmo main.cmo

clean:
	rm -f *.cmi
	rm -f *.cmo
	rm -f lispLexerLLTP.ml
	rm -f lispParserLLTP.ml
	rm -f lispParserLLTP.mli
