area
	S_inside
		icon = 'areas.dmi'
		icon_state = "shuttle"
		name = "S internals"

		verb/S_inside_AREA_TEST()
			set category = "TESTS"
			set src in world

			for(var/i = 1, i<=contents.len, i++)
				world << "[contents[i]]"



obj

	machine

		S_inside


			var/shield_cost = 0
			var/shield_reg = 0
//			var/shield_force = 0
			var/shield_force_max = 0

//			var/power = 500
			var/max_power = 0

			var/Engine_power_gen = 0

			var/Engine_trust_cost = 0

//			var/Engine_trust = 10

			var/Engine_max_trust = 0

//			var/back_power_gen = 10

			var/obj/machine/movable/shuttle/Ship/S = null

	/*		verb/TEST()
				set src in world
				world << "S = [S]"		*/

			seat
				icon = 'computer1.png'
				name = "Control panel"

			S_in
				icon = 'structures.dmi'
				name = "ladder"
				icon_state = "ladder01"

			S_ex
				icon = 'structures.dmi'
				name = "ladder"
				icon_state = "ladder10"

			propulsion
				icon = 'shuttle.dmi'
				icon_state = "propulsion"
				name = "propulsion"

				Engine_max_trust = 50

			interface
				icon = 'gateway.dmi'
				icon_state = "offcenter"
				name = "Control interface"

			engine
				icon = 'power.dmi'
				icon_state = "teg"
				name = "Engine"

				Engine_power_gen = 100
				Engine_trust_cost = 1

			smes
				icon = 'power.dmi'
				icon_state = "smes"
				name = "SMES"

				max_power = 250

			S_gen
				icon = 'structures.dmi'
				icon_state = "floorsafe"
				name = "Shield generator"

				shield_cost = 10

				shield_reg = 20

				shield_force_max = 100