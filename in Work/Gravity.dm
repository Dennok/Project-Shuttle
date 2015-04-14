obj/gravity/hole //Gravity obj

	var/G_D = 1000
	var/G = 0.1
	var/D = 0

	name = "!!HOLE!!"
//	icon = 'MEGA_COD/sing.dmi'

//	icon = 'icons/effects/224x224.dmi'
//	icon_state = "singularity_s7"

	icon = 'planet_gas_blue_512x512.png'

	pixel_x = -240
	pixel_y = -240



/datum/controller/gravity/

//	var/r
//	var/r2
//	var/F

	proc/gravitation()

		for(var/obj/gravity/hole/Y in world)


			for(var/obj/machine/movable/X in world)


				if(X.docked != 1 )


					if (X.y - Y.y < 0-Y.D)	X.mov_V+=Y.G
					if (X.y - Y.y > 0+Y.D)	X.mov_V-=Y.G

					if (X.x - Y.x < 0-Y.D)	X.mov_H+=Y.G
					if (X.x - Y.x > 0+Y.D)	X.mov_H-=Y.G

/*
		r2 = (X.y - src.y)^2 + (X.x - src.x)^2
		if (r2 == 0) return
		r = sqrt (r2)
		F = G * 100 / r2




		G_mov_H = -F * (X.x - src.x)/r

		G_mov_V = -F * (X.y - src.y)/r



		X.mov_V+=G_mov_V
		X.mov_H+=G_mov_H
*/

		//	Y.G_mov_V = X.y - Y.y
		//	Y.G_mov_H = X.x - Y.x



/*
	verb/bI()
		set src in world
//		gravitation()
		usr << "[src.x] [src.y] [src.z]"

	verb/G_bI()
		set src in world

		G = text2num(input("Enter new G:", "G", "[G]", null))

	verb/G_D_bI()
		set src in world

		G_D = text2num(input("Enter new G:", "G", "[G]", null))


	verb/D_bI()
		set src in world

		D = text2num(input("Enter new D:", "D", "[D]", null))
*/


/*

		if (G_mov_V < 0+D && G_mov_V > 0-D)
			if (G_mov_H < 0)
				X.mov_H++
			if (G_mov_H > 0)
				X.mov_H--


		if (G_mov_H < 0+D && G_mov_H > 0-D)
			if (G_mov_V < 0)
				X.mov_V++
			if (G_mov_V > 0)
				X.mov_V--
*/
/*	//-------------------
		if (X.y > src.y)
			X.mov_V++
		if (X.y < src.y)
			X.mov_V--


		if (X.x > src.x)
			X.mov_H++
		if (X.x < src.x)
			X.mov_H--
*/
//		world << "mov_V = [X.mov_V]"
	//	world << "mov_H = [X.mov_H]"