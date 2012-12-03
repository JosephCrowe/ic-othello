(*******************************************************************************
 *  Board module: contains the board class and related functions.
 *)

open Colour

type piece = colour option

(*******************************************************************************
 *  The state of an Othello board: a square array of pieces indexed by
 *  pairs of zero-based integers.
 *)
class board (size : int) =
    object (self)
        val pieces : piece array array
            = Array.make_matrix size size None

        initializer
            if size <= 2 || size mod 2 != 0 then
                invalid_arg "Size must be greater than 2 and even.";

        method setPiece (x, y) givenPiece =
            pieces.(x).(y) <- givenPiece

        method getPiece (x, y) =
            pieces.(x).(y)

        method getPieceNone at =
            try self#getPiece at
            with Invalid_argument _ -> None

        method getSize =
            size
    end;;

(*******************************************************************************
 * Constructs and returns a board with the standard starting pattern.
 *)
let standardBoard (size : int) =
    let theBoard = new board size in
    theBoard#setPiece (size/2, size/2) (Some WHITE);
    theBoard#setPiece (size/2 - 1, size/2 - 1) (Some WHITE);
    theBoard#setPiece (size/2 - 1, size/2) (Some BLACK);
    theBoard#setPiece (size/2, size/2 - 1) (Some BLACK);
    theBoard

(*******************************************************************************
 *  A human-readable representation of the given zero-based column number.
 *  This implementation only supports columns in the interval [0, 25].
 *)
let colToStr (x : int) : string =
    if 0 <= x && x <= 25 then
        String.make 1 (Char.chr (x + Char.code 'a'))
    else invalid_arg "The column number must be in [0, 25]."
;;

(*******************************************************************************
 *  A human-readable representation of the given zero-based row number.
 *)
let rowToStr (y : int) : string =
    if y >= 0 then string_of_int (y + 1)
    else invalid_arg "The row number must be non-negative."
;;

(*******************************************************************************
 *  The inverse of colToStr.
 *)
let strToCol (x : string) : int option =
    if String.length x = 1 then
        let x = x.[0] in
        if 'a' <= x && x <= 'z' then
            Some (Char.code x - Char.code 'a')
        else None
    else None
;;

(*******************************************************************************
 *  The inverse of rowToStr.
 *)
let strToRow (y : string) : int option =
    try
        let y = int_of_string y in
        if y > 0 then
            Some (y - 1)
        else None
    with Failure "int_of_string" -> None
;;
