(*******************************************************************************
 *  Player module: contains the player class.
 *)

open Colour

(*******************************************************************************
 *  An interface to a participant in a game of Othello. name is an arbitrary
 *  string to identify the player, and givenColour is the colour of pieces that
 *  the player may place.
 *)
class virtual player (name : string) (givenColour : colour) =
    object (self)        
        method getColour =
            givenColour

        method getName =
            name

        (* Decides where to place a piece, giving the coordinates. *)            
        method virtual getMove : int * int
        
        (* Notifies the player that getMove returned an invalid move. *)
        method virtual invalidMove : unit
    end;;
