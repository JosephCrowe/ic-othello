Othello: Othello.ml
	ocamlc str.cma Othello.ml   -o Othello

clean:
	rm -f *.cmi *.cmo Othello

.phony: clean
