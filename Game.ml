open Board

class type gameListener =
    object
        method gameUpdate : board -> unit
    end

class virtual game =
    object
        method virtual start : unit

        val mutable listeners : gameListener list = []

        method listen : 'a. (#gameListener as 'a) -> unit = fun listener ->
            listeners <- (listener :> gameListener) :: listeners
        
        method gameUpdate theBoard =
            List.iter (fun listener -> listener#update theBoard) listeners
    end
