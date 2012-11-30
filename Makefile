Othello: Othello.ml
	ocamlc Othello.ml -o Othello

clean:
	rm -f *.cmi *.cmo Othello

.phony: clean
