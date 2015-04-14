obj
	machine

		icon = 'mech_bay.dmi'
		icon_state = "support_lattice"

		movable

			Dock

				icon = 'circle_cruiser_272x272.png'

				pixel_x = -120
				pixel_y = -120

				var/int_loc_X = 6
				var/int_loc_Y = 7
				var/int_loc_Z = 2

				layer = 1.1

				docked = 0

				var/DockS
				var/DockM
				var/list/Dock_StanS()


				New()
					DockS = rand(2,7)
					DockM = DockS
					Dock_StanS = new(DockS)
					for(var/i = 1, i<=DockS, i++)
						var/obj/machine/Stan/S = new /obj/machine/Stan (locate(int_loc_X*i,int_loc_Y,2))
						S.D = src
						S.name = S.name + " №[i]"
						S.F_name = S.name
						Dock_StanS[i] = S
					for(var/i = 1, i<=DockS-1, i++) // Последний ангар всегда пустой.
						if(prob(75))// Наполняем ангары
							var/obj/machine/movable/shuttle/Ship/P = new /obj/machine/movable/shuttle/Ship ()
							P.forceMove(src)
							P.docked = 1
							src.contents += P

							var/obj/machine/Stan/S = Dock_StanS[i]
							S.S = P
							S.name = S.name + " to " + S.S.name

							P:Se.loc = S.loc

							step(P:Se,SOUTH,32*3)

							P:Sp.loc = P:Se.loc

							P:Sp.name = P.name

							step(P.Se,pick(NORTH,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST),32)

							DockS--




				verb/bI()
					set name = "Состояние"
					set src in world


					usr << "Всего доков = [DockM]"
					for(var/i = 1, i<=DockM, i++)
						var/E = Dock_StanS[i]
						usr << "Dock_StanS[i] = [E]"
					usr << "Свободных доков [DockS]"

				verb
					Dock()
						set name = "Стыковка"
						set category = "Стыковка"
						set src in world

						if(usr:S.x > src.x + 3 || usr:S.y > src.y + 3 || usr:S.x < src.x - 3 || usr:S.y < src.y - 3 )
							usr << "Слишком далеко"
							return

						if(usr:S==null)return

						if (usr:S.mov_H > src.mov_H + 5 || usr:S.mov_V > src.mov_V + 5 || usr:S.mov_H < src.mov_H - 5 || usr:S.mov_V < src.mov_V - 5)
							usr << "ДлЯ стыковки необходимо сравнять скорость."
							return

						if(src.DockS==0)
							usr << "Нет стыковочных мест."
							return


						var/obj/machine/Stan/S = src.Dock_StanS[rand(1,src.DockM)]

						if(S.S!=null)
							Dock()
							return

						S.S = usr:S

						world << "[usr:S.name] dock to [src.name]."
						usr:S.forceMove(src)
						usr:S.docked = 1
						src.contents += usr:S

						usr << "Стыковка к [src.name] на площадку [S.name] успешна."
						S.name = S.name + " to " + S.S.name

						usr:S:Se.loc = S.loc
						usr:S:Se.name = "Ladder to [usr:S.name]"
						step(usr:S:Se,SOUTH,32*3)
						usr:S:Sp.loc = usr:S:Se.loc
						usr:S:Sp.name = usr:S.name

						step(usr:S:Se,pick(NORTH,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST),32)

			//			usr:S.P.Drp_control()
						src.DockS--

				verb
					Undock()
						set name = "Разстыковка"
						set category = "Стыковка"
						set src in world

						if(!(usr:S in src.contents))return

						if(usr:S==null)return

						usr:S.Se.loc = usr:S
						usr:S.contents += usr:S.Se

						usr:S.loc = src.loc
						usr:S.mov_V = src.mov_V
						usr:S.mov_H = src.mov_H

						usr:S:Sp.loc = usr:S

						usr:S.docked = 0

						world << "[usr:S.name] undock wisch [src.name]."

					//	S = null

					//	name = F_name

						src.DockS++


		Stan



			var/F_name

			icon = 'mech_bay.dmi'
			icon_state = "support_lattice"

			var/obj/machine/movable/shuttle/Ship/S = null
			var/obj/machine/movable/Dock/D = null


/atom/movable/proc/forceMove(atom/destination)
	if(destination)
		if(loc)
			loc.Exited(src)
		loc = destination
		loc.Entered(src)
		return 1
	return 0