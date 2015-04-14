/*
	These are simple defaults for your project.
 */
world
	fps = 32
	icon_size = 32

	view = 10

/client/verb/Set_view()
	view = text2num(input("Enter view range:", "view range", "[view]", null))


obj
	step_size = 1

mob
/*	Stat()
		stat("description",src.desc)
		if(src == usr) stat(src.contents)

	desc = "ЫЫЫ"*/
	density = 1
	verb
		say(msg as text)
			world << "[usr] says, [msg]"

		Sas()
			var/a = 0
			var/b = 1
			if(a|b) world << "Sss"
/*
mob/verb/drink()
	var/icon/I = new(usr.icon)
	I.Turn(45)
	usr.icon = I
	usr << "You feel a little tipsy!"

mob/verb/drinkdrinkdrink()
	var/T = 90
//	var/t = 1
	for(var/u = 1, u <= 3600, u++)
		var/icon/I = new(usr.icon)
		I.Turn(T)
		usr.icon = I
		sleep(0.1)
		T--
mob/verb/Del_drink()
	verbs.Remove(/mob/verb/drink,
		/mob/verb/drinkdrinkdrink,
		/mob/verb/Del_drink)
*/
mob/verb/Teleport()
	if(usr:S!=null)
		usr:S.loc = locate(text2num(input("Enter X:", "X", "", null)),text2num(input("Enter Y:", "Y", "", null)),text2num(input("Enter Z:", "Z", "", null)))
	else
		usr.loc = locate(text2num(input("Enter X:", "X", "", null)),text2num(input("Enter Y:", "Y", "", null)),text2num(input("Enter Z:", "Z", "", null)))

/client
	var/mob/Pilot = null

	var/LoL = 1

	verb/LoL()
		usr.dir = text2num(input("LoL", "lOl", "[usr.client.dir]", null))

		var/obj/Ship_phantom/B = new /obj/Ship_phantom
		B.screen_loc = "1,1"
		usr.client.screen += B

	verb/LoL_TEST()
		LoL = !LoL

mob

	var/S_upravlenie = 0

	var/obj/machine/movable/shuttle/Ship/S = null
	step_size = 1

	icon = 'syndiflag.dmi'
	icon_state = ""

	Login()
		loc = locate(/area/start)
		if(usr.client.Pilot==null)
			spawn ()
				call(/mob/verb/Get_my_body)()

		else return

	Pilot
		icon = 'mob.dmi'
		icon_state = ""
		step_size = 32

		var/obj/target = null

		Stat()
			if (usr:S == null ) return
			stat(null, "mov_V: [usr:S.mov_V]")
			stat(null, "mov_H: [usr:S.mov_H]")
			stat(null, "napravlenie: [usr:S.napravlenie]")
			stat(null, "power: [usr:S.power]/[usr:S.max_power]")
			stat(null, "shield: [usr:S.shield_force]/[usr:S.shield_force_max]")
			stat(null, "Speed_safe [(usr:S.speed_safe)?"ON":"OFF"] Safe_speed: [usr:S.Safe_speed]")
			stat(null, "Engine = [(usr:S.Engine)?"ON":"OFF"]")
			stat(null, "Shield = [(usr:S.shield)?"ON":"OFF"]")
			stat(null, "Target =[(target)?" [target] Range: V [target.y - usr:S.y] H [target.x - usr:S.x] D_Speed: V [Ceiling((target.mov_V - usr:S.mov_V)*10)/10] H [Ceiling((target.mov_H - usr:S.mov_H)*10)/10]":"OFF"]")

mob/verb/Get_my_body()
	set hidden = 1
	var/O = usr.client.mob
	var/mob/Pilot/P = new /mob/Pilot
	usr.client.Pilot = P
	P.name = "Pilot "+usr.name
	P.client = usr.client
	P.S_upravlenie=0
	P.x = 2
	P.y = 2
	P.z = 2
	del O


mob/verb/Get_new_Ship()
	var/obj/machine/movable/shuttle/Ship/P = new /obj/machine/movable/shuttle/Ship (usr.loc)
	call(/mob/Pilot/verb/Get_control)(P.Ss)

	P.docked = 1

	P.mov_V = text2num(input("Enter mov_V:", "mov_V", "[P.mov_V]", null))

	P.docked = 1

	P.mov_H = text2num(input("Enter mov_H:", "mov_H", "[P.mov_H]", null))

	P.docked = 0

	P.Pereklucit_Engine()

turf
	layer = 1
	name = "space"
	icon = 'icons/space.dmi'
	icon_state = "0"

	New()
		icon_state = num2text(rand(1,25))

	floor
		icon = 'icons/floors.dmi'
		name = "floor"
	space
		icon = 'icons/space.dmi'
		icon_state = "25"
		name = "SPACE"

		New()
			icon_state = num2text(rand(1,25))

	wall
		icon = 'icons/walls.dmi'
		density = 1
		opacity = 1
		name = "wall"
	glass
		icon = 'icons/glass.dmi'
		density = 1
		opacity = 0
		name = "glass"

area/start
	icon = 'icons/areas.dmi'
	icon_state = "start"
/*
obj
	verb
		get()
			set src in oview(0)
			usr << "You get [src]."
			Move(usr)
		drop()
			usr << "You drop [src]."
			Move(usr.loc)
*/
obj
	linebin
//		icon = 'Linebin.dmi'
		icon = 'planet_gas_blue_512x512.png'

	paper
		icon = 'syndiflag.dmi'


mob/Pilot/verb/Set_Ship_name()
	if (usr:S==null) return
	usr:S.name = input("Enter new name:", "Ship hame", "[usr:S.name]", null) + " №[usr:S.number]"
/*
mob/Pilot/verb/Board2Ship(var/obj/machine/movable/shuttle/Ship/O as obj in world)
//	set name = "Взайти на борт"
	set category = "System"
	set hidden = 1
/*
	if(!istype(O,/obj/machine/movable/shuttle/Ship))
		usr << "You cant board to [O]."
		return

	if(usr.S)
		usr << "You have alredy board."
		return
*/
//	usr.client.eye = O
	usr.loc = O.Si.loc
*/
mob/Pilot/verb/Board2Se(var/obj/machine/S_inside/S_ex/O in view(0))
	set name = "Взайти на борт"
	set category = "Move&Control"

	if(istype(O,/obj/machine/S_inside/S_ex))
		usr.loc = O.S.Si.loc
		return


mob/Pilot/verb/Get_control(var/obj/machine/S_inside/seat/O as obj in view(0))
	set name = "Взять управление"
	set category = "Move&Control"

	usr.S_upravlenie=1
	usr:S = O.S
	O.S.P = usr
	usr.loc = O.S
	O.S.contents += usr
	usr.client.eye = O.S

//	if(O.S.docked == 1) usr:S.Undock()

mob/Pilot/verb/Drp_control()
	set name = "Бросить управление"
	set category = "Move&Control"

	if(usr:S==null)	return

	usr.S_upravlenie=0
	usr.loc = usr:S.Ss.loc
	usr.client.eye = usr

	usr:S.P = null
	usr:S = null


mob/Pilot/verb/release(var/obj/machine/S_inside/S_in/O as obj in view(0))
	set name = "Покинуть корабль"
	set category = "Move&Control"



	usr.loc = O:S.Se.loc
	usr.client.eye = usr
	step(usr,1)
	step(usr,2)

mob/Pilot/verb/Set_target(var/obj/machine/movable/O as obj in world)
//	set src in world
	set name = "Установить цель"
	usr:target = O