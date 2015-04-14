/client/verb/Set_Move_Delay()
	set name = "Move_Delay"
	set category = "System"
	Move_Delay = text2num(input("Enter Move_Delay:", "Move_Delay", "[Move_Delay]", null))

var/global/Move_Delay = 1

obj

	var/mov_V = 0
	var/mov_H = 0

	var/mob/Pilot/P = null

//	var/list/Icons()

	machine
		movable
			var/docked = 0

	/*		verb/TEST()
				set src in world
				world << "pix = [pixel_x] [pixel_y]"*/

			shuttle

				Ship

					var/number = null
					var/list/S_inside = new()


					verb/TEST_S_inside()
						set category = "TESTS"
						set src in world

						for(var/i = 1, i<=S_inside.len, i++)
					//		world << "[S_inside[i]]"

							var/area/S = S_inside[i]
							var/list/SI = S.contents

							for(var/o = 1, o<=SI.len, o++)
								world << "[SI[o]]"

					proc/Refresch_inside(var/obj/machine/movable/shuttle/Ship/O)

						O.I = new ()

						for(var/i = 1, i<=O.S_inside.len, i++)

							var/area/S = O.S_inside[i]
							var/list/SI = S.contents

							for(var/o = 1, o<=SI.len, o++)
								var/turf/D = SI[o]
								if (D.type != /turf/wall && D.type != /turf/floor && D.type != /turf/glass)

									var/obj/machine/S_inside/bI = SI[o]
									O.I.Add (bI)

									shield_cost += bI.shield_cost
									shield_reg += bI.shield_reg
									shield_force_max += bI.shield_force_max
									max_power += bI.max_power
									Engine_power_gen += bI.Engine_power_gen
									Engine_trust_cost += bI.Engine_trust_cost
									Engine_max_trust += bI.Engine_max_trust




					var/list/I = new ()

					var/obj/machine/S_inside/seat/Ss = null
					var/obj/machine/S_inside/S_in/Si = null
					var/obj/machine/S_inside/S_ex/Se = null
					var/obj/Ship_phantom/Sp = null

					icon = 'beam_pack.dmi'
					icon_state = "0 0"

					pixel_x = -16
					pixel_y = -16

					var/S_interlal_X = null
					var/S_interlal_Y = null
					var/S_interlal_Z = null

					step_size = 1


					mov_V = 0
					mov_H = 0

					var/Engine = 0
					var/shield = 0

					var/shield_cost = 0 //10
					var/shield_reg = 0 //20
					var/shield_force = 0
					var/shield_force_max = 0 //100

					var/speed_safe = 0
					var/Safe_speed = 5
					var/napravlenie = 0

					var/power = 500
					var/max_power = 0 //500

					var/power_safe = 1
					var/safe_power = 100

					var/Engine_power_gen = 0 //100
					var/Engine_trust_cost = 0 //1
					var/Engine_trust = 10
					var/Engine_max_trust = 0 //100
					var/back_power_gen = 10

					New()
						number = rand(0,10000)
						name = name + " №[number]"

						Build_Internals()

						spawn(0)
							Refresch_inside(src)



					verb/ADD_HUD()
						set src in oview(0)
						set category = "Корабль"

						var/obj/overlay/usr_HUD_icons/shield/B = new /obj/overlay/usr_HUD_icons/shield/
						B.screen_loc = "5,5"
						usr.client.screen += B

						var/obj/overlay/usr_HUD_icons/engine/E = new /obj/overlay/usr_HUD_icons/engine/
						E.screen_loc = "6,5"
						usr.client.screen += E

					verb/Info()
						set src in oview(0)
						set category = "Корабль"

						for(var/i=1, i<=I.len, i++)
							world << "[I[i]]"


					verb/power_safe()
						set src in oview(0)
						set category = "Корабль"

						power_safe=!power_safe
						if(power_safe)
							safe_power = text2num(input("Enter safe_power:", "safe_power", "[safe_power]", null))
						else
							safe_power = 0
						usr << "power_safe = [(power_safe)?"Активирован. safe_power = [safe_power]":"Деактивирован"]"

					verb/shield_reg()
						set src in oview(0)
						set category = "Корабль"

						shield_reg = text2num(input("Enter shield_reg:", "shield_reg", "[shield_reg]", null))
						usr << "shield_reg установлен на [shield_reg]"


					verb/Engine_trust()
						set src in oview(0)
						set category = "Корабль"

						Engine_trust = text2num(input("Enter Engine_trust:", "Engine_trust", "[Engine_trust]", null))
						usr << "Engine_trust установлен на [Engine_trust]"

					verb/speed_safe()
						set name = "Ограничитель скорости"
						set category = "Корабль"
						set src in oview(0)

						speed_safe=!speed_safe
						usr << "speed_safe = [(speed_safe)?"Активирован":"Деактивирован"]"

						if( mov_V>Safe_speed || mov_H>Safe_speed )

							if( mov_V>Safe_speed ) mov_V = Safe_speed
							if( mov_H>Safe_speed ) mov_H = Safe_speed

							usr << "mov_V = [mov_V]"
							usr << "mov_H = [mov_H]"

					verb/Pereklucit_Engine()
						set name = "Зажигание"
						set category = "Корабль"
						set src in oview(0)

						if(Engine)

							usr.S.icon_state = "[napravlenie] disable"
							sleep (10)
							usr.S.icon_state = "[napravlenie] [0]"

						else
							if( power < Engine_power_gen * 2 )
								usr << "Не достаточно энергии длЯ запуска двигателя."
								return
							power -= Engine_power_gen * 2

							usr.S.icon_state = "[napravlenie] activa"
							sleep (10)
							usr.S.icon_state = "[napravlenie] [1]"

						Engine = !Engine
						usr << "Engine = [(Engine)?"Активирован":"Деактивирован"]"

					verb/Pereklucit_shield()
						set name = "Щит"
						set category = "Корабль"
						set src in oview(0)

						if(shield)
					//		usr.S.icon_state = "shield_dis"
					//		sleep (10) //Возможно таки да сделаю анимацию.
					//		usr.S.icon_state = "[napravlenie] [1]"

							overlays -= /obj/overlay/Ship_effects/shieldold

						else

							if( power < shield_cost * 2 )
								usr << "Не достаточно энергии для запуска щита."
								return

							power -= shield_cost
							if(!Engine)
								usr << "Настоятельно рекомендуетса активировать двигатель."

							overlays += /obj/overlay/Ship_effects/shieldold

					//		usr.S.icon_state = "shield_act"
					//		sleep (10) //Возможно таки да сделаю анимацию.
					//		usr.S.icon_state = "[napravlenie] [1]"

						shield=!shield
						usr << "Shield = [(shield)?"Активирован":"Деактивирован"]"


					verb/Set_Safe_speed()
						set name = "Установка ограничения скорости"
						set category = "Корабль"
						set src in oview(0)

						Safe_speed = text2num(input("Enter Safe_speed:", "Safe_speed", "[Safe_speed]", null))




					proc/Build_Internals()
/*
						S_interlal_X = 6 * ships_spawned
						S_interlal_Y = 32
						S_interlal_Z = 2

						Ss = new /obj/machine/S_inside/seat (locate(S_interlal_X,S_interlal_Y,S_interlal_Z))
						Ss.S = src

						I.Add(Ss)
						I.Add( new /obj/machine/S_inside/interface (locate(S_interlal_X,S_interlal_Y+1,S_interlal_Z)) )

						Si = new /obj/machine/S_inside/S_in	(locate(S_interlal_X,S_interlal_Y-2,S_interlal_Z))
						Si.S = src
						Se = new /obj/machine/S_inside/S_ex
						Se.forceMove(src)
						Se.S = src
						Sp = new /obj/Ship_phantom
						Sp.forceMove(src)

						I.Add( new /obj/machine/S_inside/propulsion (locate(S_interlal_X-1,S_interlal_Y-3,S_interlal_Z)) )
						I.Add( new /obj/machine/S_inside/propulsion (locate(S_interlal_X+1,S_interlal_Y-3,S_interlal_Z)) )

						I.Add( new /obj/machine/S_inside/engine (locate(S_interlal_X,S_interlal_Y-3,S_interlal_Z)) )
						I.Add( new /obj/machine/S_inside/smes (locate(S_interlal_X+1,S_interlal_Y-2,S_interlal_Z)) )
						I.Add( new /obj/machine/S_inside/smes (locate(S_interlal_X-1,S_interlal_Y-2,S_interlal_Z)) )

						I.Add( new /obj/machine/S_inside/S_gen (locate(S_interlal_X,S_interlal_Y-1,S_interlal_Z)) )
					*/
						S_interlal_X = 6 * ships_spawned
						S_interlal_Y = 32
						S_interlal_Z = 1

						Ss = new /obj/machine/S_inside/seat (locate(S_interlal_X,S_interlal_Y,S_interlal_Z))
						Ss.S = src

						new /obj/machine/S_inside/interface (locate(S_interlal_X,S_interlal_Y+1,S_interlal_Z))

						Si = new /obj/machine/S_inside/S_in	(locate(S_interlal_X,S_interlal_Y-2,S_interlal_Z))
						Si.S = src
						Se = new /obj/machine/S_inside/S_ex
						Se.forceMove(src)
						Se.S = src
						Sp = new /obj/Ship_phantom
						Sp.forceMove(src)

						new /obj/machine/S_inside/propulsion (locate(S_interlal_X-1,S_interlal_Y-3,S_interlal_Z))
						new /obj/machine/S_inside/propulsion (locate(S_interlal_X+1,S_interlal_Y-3,S_interlal_Z))

						new /obj/machine/S_inside/engine (locate(S_interlal_X,S_interlal_Y-3,S_interlal_Z))
						new /obj/machine/S_inside/smes (locate(S_interlal_X+1,S_interlal_Y-2,S_interlal_Z))
						new /obj/machine/S_inside/smes (locate(S_interlal_X-1,S_interlal_Y-2,S_interlal_Z))

						new /obj/machine/S_inside/S_gen (locate(S_interlal_X,S_interlal_Y-1,S_interlal_Z))



/*
							for(var/x = 0,x<x_size,x++)
		for(var/y = 0,y<y_size,y++)
			var/turf/T
			var/cur_loc = locate(start_loc.x+x,start_loc.y+y,start_loc.z)
			if(clean)
				for(var/O in cur_loc)
					del(O)

						var/area/asteroid/artifactroom/A = new
			if(name)
				A.name = name
			else
				A.name = "Artifact Room #[start_loc.x][start_loc.y][start_loc.z]"



			if(x == 0 || x==x_size-1 || y==0 || y==y_size-1)
				if(wall == /obj/effect/alien/resin)
					T = new floor(cur_loc)
					new /obj/effect/alien/resin(T)
				else
					T = new wall(cur_loc)
					room_turfs["walls"] += T
			else
				T = new floor(cur_loc)
				room_turfs["floors"] += T

			A.contents += T


	return room_turfs */




						for(var/u = 1, u <= 5, u++)
							for(var/i = 1, i <= 5, i++)

								var/turf/T

								if ( u == 1 || i == 1 || u == 5 || i == 5 )
									T = new /turf/wall (locate(S_interlal_X+i-1-2,S_interlal_Y - 3+u-1,S_interlal_Z))
								else
									T = new /turf/floor (locate(S_interlal_X+i-1-2,S_interlal_Y - 3+u-1,S_interlal_Z))

								if ( i == 3 && u == 1 ) T = new /turf/floor (locate(S_interlal_X+i-1-2,S_interlal_Y+u-1-3,S_interlal_Z))
								if ( i == 3 && u == 5 ) T = new /turf/glass (locate(S_interlal_X+i-1-2,S_interlal_Y+u-1-3,S_interlal_Z))

								var/area/S_inside/S_in = new
								if(name)
									S_in.name = name
								else
									S_in.name = "Shuttle Internals #[number]"
								S_in.contents += T
								S_inside.Add(S_in)






						ships_spawned++

				//	proc/Rebuild_Internals(var/obj/machine/movable/shuttle/Ship/S)







					big
						Stels
							..()

							name = "Stels"

							icon = 'stealth_152x152.png'
							pixel_x = -60
							pixel_y = -60




					verb/Dock2Target()
						set name = "Стыковка к цели"
						set category = "Корабль"
						set src in oview(0)
						if ( usr:target.type == /obj/machine/movable/Dock )
							var obj/machine/movable/Dock/D = usr:target
							usr.client.eye = D
							D.Dock()





obj

	Ship_phantom

		icon = 'drone_beam_off_104x104.png'
		name = "Ship_phantom"
		pixel_x = -36
		pixel_y = -36
		layer = 5

	overlay

		Ship_effects

			icon = 'effects.dmi'

			pixel_x = 16
			pixel_y = 16

			shieldold
				icon_state = "shield-old"

			shield
				icon_state = "shield"

			m_shield
				icon_state = "m_shield"

			shield1
				icon_state = "shield1"

			shield2
				icon_state = "shield2"

			at_shield1
				icon_state = "at_shield1"

			at_shield2
				icon_state = "at_shield2"

			energynet
				icon_state = "energynet"

			electricity
				icon_state = "electricity"

			empdisable
				icon_state = "empdisable"

			Engine
				beam
					icon = 'beam_engine.dmi'
					icon_state = "0"
					pixel_x = 0
					pixel_y = 0

///obj/overlay/Ship_effects/Engine/beam

		usr_HUD_icons

			icon = 'HUD.dmi'

			screen_loc = "1,1"

			verb/change_S_loc()
				set src in world
				src.screen_loc = "[input("X", "X", "1", null)],[input("Y", "Y", "1", null)]"

		//	Click()
		//		usr.Get_new_Ship()


			shield
				icon_state = "s_shields_overlay.png"

				Click()
					usr:S.Pereklucit_shield()

			engine
				icon_state = "engine"

				Click()
					usr:S.Pereklucit_Engine()
