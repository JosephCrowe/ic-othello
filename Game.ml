open Board
open Player

class type gameListener =
    object
        method gameUpdate : board -> unit

        method gameWon : player -> unit
        
        method gameDrawn : unit
    end;;

class virtual game =
    object
        method virtual start : unit

        val mutable listeners : gameListener list = []

        method listen : 'a. (#gameListener as 'a) -> unit = fun listener ->
            listeners <- (listener :> gameListener) :: listeners
        
        method gameUpdate theBoard =
            List.iter (fun l -> l#gameUpdate theBoard) listeners

        method gameWon thePlayer =
            List.iter (fun l -> l#gameWon thePlayer) listeners
        
        method gameDrawn =
            List.iter (fun l -> l#gameDrawn) listeners
    end;;
