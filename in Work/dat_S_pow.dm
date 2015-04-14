var/global/datum/controller/Ship_power

/datum/controller/Ship_power

	proc/Process()
		for ( var/obj/machine/movable/shuttle/Ship/S in world )

			S.power += S.back_power_gen

			if ( S.Engine ) S.power += S.Engine_power_gen

			if ( S.shield )

				if ( S.shield_force >= S.shield_force_max && S.power - S.shield_force_max * S.shield_cost * S.shield_reg / 1000 >= 0)
					S.shield_force = ( S.shield_force_max + S.shield_force ) / 2
					S.power -= S.shield_force_max * S.shield_cost * S.shield_reg / 1000

				else

					if ( S.power - S.safe_power - S.shield_cost * S.shield_reg <= 0 )
						S.P << "ЭнергиЯ на критическом уровне.\nЭкстренное отключение щита!"
						S.shield = 0
					//	S.shield_force = 0
						S.overlays -= /obj/overlay/Ship_effects/shieldold

					else

						S.power -= S.shield_cost * S.shield_reg
						S.shield_force += S.shield_reg
						if ( S.shield_force >= S.shield_force_max )	S.shield_force = S.shield_force_max
			else
				if ( S.shield_force > 0 && prob(15) ) S.shield_force--



			if ( S.power > S.max_power ) S.power = S.max_power

			if ( S.power < 0 )
				S.P << "Нет энергии! Двигатель захлох!"
				S.power = 0
				S.shield = 0
				S.Engine = 0
				S.icon_state = "[S.napravlenie] disable"
				sleep (10)
				S.icon_state = "[S.napravlenie] [0]"