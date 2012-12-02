(*******************************************************************************
 *  GameInterface module: contains the gameInterface class.
 *)

open Board
open Player
open Game

(*******************************************************************************
 *  A gameListener wrapping a single game instance and listening to its events.
 *)
class virtual gameInterface (theGame : #game) =
    object (self : #gameListener)
        inherit gameListener

        initializer
            theGame#listen self

        (* Begins gameplay of the underlying game, returning when it ends. *)
        method start
            = theGame#start
    end;;
