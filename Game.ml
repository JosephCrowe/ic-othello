(*******************************************************************************
 *  Game module: contains the gameListener and game classes.
 *)

open Board
open Player

(*******************************************************************************
 *  The base class of objects capable of subscribing to events from a game.
 *)
class virtual gameListener =
    object
        (* The state of the board has changed to that given. *)
        method virtual gameUpdate : board -> unit

        (* The given player had no legal moves to make, so their turn was
           skipped. *)
        method virtual gameSkip : player -> unit

        (* The game ended, with the given player winning. *)
        method virtual gameWon : player -> unit
        
        (* The game ended with no player winning. *)
        method virtual gameDrawn : unit
    end;;

(*******************************************************************************
 *  Represents an ongoing game of Othello. The gameplay dynamics are not
 *  specified by this class, which only implements the external events a game
 *  can broadcast, so must be implemented by subclasses.
 *)
class virtual game =
    object
        (* Begins gameplay, returning when the game has ended. *)
        method virtual start : unit

        (* The list of objects receiving game events. *)
        val mutable listeners : gameListener list = []

        (* Registers the given object to listen for game events. If this method
           is called twice with the same object, that object will recieve each
           event twice. *)
        method listen : 'a. (#gameListener as 'a) -> unit = fun listener ->
            listeners <- (listener :> gameListener) :: listeners

        (* Notifies of the gameUpdate event. *)
        method gameUpdate theBoard =
            List.iter (fun l -> l#gameUpdate theBoard) listeners

        (* Notifies of the gameSkip event. *)
        method gameSkip thePlayer =
            List.iter (fun l -> l#gameSkip thePlayer) listeners

        (* Notifies of the gameWon event. *)
        method gameWon thePlayer =
            List.iter (fun l -> l#gameWon thePlayer) listeners
        
        (* Notifies of the gameDrawn event. *)
        method gameDrawn =
            List.iter (fun l -> l#gameDrawn) listeners
    end;;
