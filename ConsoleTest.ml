(*******************************************************************************
 *  Tests the consoleGame and humanPlayer classes with a trivial implementation
 *  of the game class.
 *)

open HumanPlayer
open ConsoleGame
open Board
open Colour
open Game

(*******************************************************************************
 *  A game of Othello where a single player places black pieces at arbitrary
 *  locations on the board.
 *)
class testGame =
    object (self)
        inherit game

        val thePlayer = new humanPlayer "Tester" BLACK

        val theBoard = new board 16

        method start =
            self#gameUpdate theBoard;
            self#getMove;

        method private getMove =
            let move = thePlayer#getMove in
            try
                theBoard#setPiece move (Some thePlayer#getColour);
                self#start
            with Invalid_argument _ ->
                thePlayer#invalidMove;
                self#getMove            
    end;;

(new consoleGame (new testGame))#start
