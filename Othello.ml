type piece = EMPTY | BLACK | WHITE

class board size =
	if (size <= 2 || (size mod 2) != 0)
		then invalid_arg "Size must be greater than 2 and even.";
	object(self)
		val pieces = Array.make_matrix size size EMPTY
		
	end
	

