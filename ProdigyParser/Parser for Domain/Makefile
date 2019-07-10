all: 	
	ocamllex DomainLexer.mll     
	ocamlyacc DomainParser.mly
	ocamlc -c DomainParser.mli
	ocamlc -c DomainLexer.ml
	ocamlc -c DomainParser.ml
	ocamlc -c main.ml
	ocamlc -o main DomainLexer.cmo DomainParser.cmo main.cmo
