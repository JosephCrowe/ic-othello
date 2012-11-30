type piece = EMPTY | BLACK | WHITE

class board size =
    object (self)
        initializer
            if size <= 2 || size mod 2 = 0 then
                invalid_arg "Size must be greater than 2 and even."
        val pieces = Array.make_matrix size size EMPTY
	end

