-- task 03 func_sum helper — the add_one(n) = n + 1 of the C row, in its own class and
-- therefore in its own file and its own C translation unit.
class
	ADD_ONE

create
	make

feature -- Initialization

	make
			-- Nothing to initialize.
		do
		end

feature -- Access

	add_one (n: INTEGER_64): INTEGER_64
			-- n + 1
		do
			Result := n + 1
		end

end
