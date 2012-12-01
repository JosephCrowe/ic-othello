open Colour
open Board
open Player

class virtual gameInterface =
    object (self)
        method virtual gameUpdate : board -> unit

        method virtual gameOver : player -> unit
    end;;

class consoleGameInterface =
    object (self)
        inherit gameInterface

        method gameUpdate theBoard =
            let pad n str = str ^ String.make (n - String.length str) ' ' in

            let size = theBoard#getSize in
            let rowHeads = Array.init size rowToStr in
            let colHeads = Array.init size colToStr in
            let colWidth = 1 + Array.fold_left max 0 (Array.map String.length colHeads) in
            let headWidth = 1 + Array.fold_left max 0 (Array.map String.length rowHeads) in

            print_string (pad headWidth "");
            Array.iter (fun str -> print_string (pad colWidth str)) colHeads;
            print_newline ();

            for y = 0 to size - 1 do
                print_string (pad headWidth rowHeads.(y));
                for x = 0 to size - 1 do
                    let symbol = match theBoard#getPiece (x, y) with
                    |   Some WHITE  -> "o"
                    |   Some BLACK  -> "x"
                    |   None        -> "." in
                    print_string (pad colWidth symbol)
                done;
                print_newline ()
            done;

        method gameOver winPlayer =
            print_endline (winPlayer#getName ^ " wins.")
    end;;
