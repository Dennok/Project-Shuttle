/datum/controller/Space_move_system

	proc/S_M_S_work()	//Move all movable obj in vorld

		for ( var/obj/machine/movable/X in world )

			if(X.docked != 1 )

				if (X.mov_V != 0)

					if (X.mov_V > 0)
						step(X,NORTH,abs(X.mov_V))
					else
						step(X,SOUTH,abs(X.mov_V))

				if (X.mov_H != 0)

					if (X.mov_H > 0)
						step(X,EAST,abs(X.mov_H))
					else
						step(X,WEST,abs(X.mov_H))

