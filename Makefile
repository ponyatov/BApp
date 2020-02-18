CWD    = $(CURDIR)
MODULE = $(notdir $(CWD))

NOW = $(shell date +%d%m%y)
REL = $(shell git rev-parse --short=4 HEAD)

.PHONY: all
all: ./bapp bap.bap
	./$^

./bapp: frame.cmo bap_lexer.cmo bap_parser.cmo main.cmo
	ocamlc -o $@ $^

main.cmo: main.ml bap_lexer.cmi bap_parser.cmi
	ocamlc -c $<
%_lexer.cmo: %_lexer.ml %_parser.cmi
	ocamlc -c $<
%.cmo: %.ml
	ocamlc -c $<
%.cmi: %.mli
	ocamlc -c $<

%_lexer.ml: %_lexer.mll
	ocamllex $<
%_parser.ml %_parser.mli: %_parser.mly
	ocamlyacc $<
