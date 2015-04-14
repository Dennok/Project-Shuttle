var/global/datum/controller/Ticker

/datum/controller/Ticker

	New()
		spawn(10)
			Tick()
			world << "¬ремя пошло"

	proc/Tick()
		set background = 1
		spawn while(1)

			call(/datum/controller/Space_move_system/proc/S_M_S_work)()
			call(/datum/controller/gravity/proc/gravitation)()
			call(/datum/controller/Ship_power/proc/Process)()

			sleep(10/Move_Delay)
/*			spawn(10/Move_Delay)
				Tick()*/
//			world << "TiK"


