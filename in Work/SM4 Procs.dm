/client/verb/Pereklucit_upravlenie_na_nogi()
	usr.S_upravlenie=0
	usr << "Система шаганиЯ активирована"

/client/verb/Pereklucit_upravlenie_na_cor()
	usr.S_upravlenie=1
	usr << "Система управлениЯ кораблем активирована"

client/Center() // Стоn

	if(usr.S_upravlenie == 0)
		..()
		return

	if(!usr.client.mob.S.Engine)
		usr << "Необходимо активировать двигатель."
		return

	if (usr:target == null )
		usr << "Нет цэли"
		return

	if ( (1/100) * usr:S.Engine_trust < ( usr:S.mov_H + usr:target.mov_H ) / 2) //если труст корабля меньше необходимого то меняем скорость.

		if ( usr:S.power - usr:S.Engine_trust_cost * ( usr:S.mov_H + usr:target.mov_H ) / 2 >= usr:S.safe_power )

			if (usr:S.mov_H - usr:target.mov_H < 0)	usr:S.mov_H+=(1/100) * usr:S.Engine_trust
			if (usr:S.mov_H - usr:target.mov_H > 0)	usr:S.mov_H-=(1/100) * usr:S.Engine_trust

			usr:S.power -= usr:S.Engine_trust_cost * usr:S.Engine_trust

	if ( (1/100) * usr:S.Engine_trust < ( usr:S.mov_H + usr:target.mov_H ) / 2)

		if ( usr:S.power - usr:S.Engine_trust_cost * ( usr:S.mov_V + usr:target.mov_V ) / 2 >= usr:S.safe_power )

			if (usr:S.mov_V - usr:target.mov_V < 0)	usr:S.mov_V+=(1/100) * usr:S.Engine_trust
			if (usr:S.mov_V - usr:target.mov_V > 0)	usr:S.mov_V-=(1/100) * usr:S.Engine_trust

			usr:S.power -= usr:S.Engine_trust_cost * usr:S.Engine_trust




proc/Change_Direc(D)

	if ( usr:S.power - usr:S.Engine_trust_cost * 2 < usr:S.safe_power ) return

	usr:S.power -= usr:S.Engine_trust_cost * 4 // Два пшика для поворотА и два для остановки.

	var/napravlenie = usr.client.mob.S.napravlenie

	if(D==4)
		D = 45
	else
		D = -45

	napravlenie+=D

	if (napravlenie==360) napravlenie = 0
	if (napravlenie==-45) napravlenie = 315


	usr:S.icon_state = "[napravlenie] [usr:S.Engine]"
	usr.client.mob.S.napravlenie = napravlenie
/*
	var/obj/overlay/Ship_effects/Engine/beam/B = /obj/overlay/Ship_effects/Engine/beam
	for(B in usr:S.overlays) //эта гадина не пашет
		B.icon_state = "[usr:S.napravlenie]"
		world << "ssssssssssss"
*/

proc/Change_Speed(D)

	if ( usr:S.power - usr:S.Engine_trust_cost * usr:S.Engine_trust < usr:S.safe_power ) return

	usr:S.power -= usr:S.Engine_trust_cost * usr:S.Engine_trust

	var/speed_safe = usr:S.speed_safe
	var/Safe_speed = usr:S.Safe_speed
	var/mov_H = usr:S.mov_H
	var/mov_V = usr:S.mov_V
	var/A = usr:S.napravlenie

	var/trust = (1/100) * usr:S.Engine_trust

	if(D==1)
		D = trust
	else
		D = -trust
	if(A == 0 || A == 360) mov_V+=D
	if(A == 45)
		mov_H+=D
		mov_V+=D
	if(A == 90)
		mov_H+=D
	if(A == 135)
		mov_H+=D
		mov_V-=D
	if(A == 180)
		mov_V-=D
	if(A == 225)
		mov_H-=D
		mov_V-=D
	if(A == 270)
		mov_H-=D
	if(A == 315)
		mov_H-=D
		mov_V+=D

	if(speed_safe)
		if(mov_V > Safe_speed) mov_V = Safe_speed
		if(mov_V < -Safe_speed) mov_V = -Safe_speed

		if(mov_H > Safe_speed) mov_H = Safe_speed
		if(mov_H < -Safe_speed) mov_H = -Safe_speed


	usr:S.mov_H = mov_H
	usr:S.mov_V = mov_V

	var/obj/overlay/Ship_effects/Engine/beam/B = new /obj/overlay/Ship_effects/Engine/beam
	B.icon_state = "[usr:S.napravlenie]"
	usr:S.overlays += B
	spawn (10)
	usr:S.overlays -= B
//	usr << "mov_V = [mov_V]"
//	usr << "mov_H = [mov_H]"
//	usr:S.verbs.mov_V set name = num2text(mov_V)
//	usr:S.verbs.mov_H set name = num2text(mov_H)

/client/Move(n, direct, params)
//	var/list/pa = params2list(params)

//	usr << "[direct]"

	if(usr.S_upravlenie == 0)

		if(usr.client.LoL)
	//		world << "1"
			..()
		else
	//		world << "2"
/*			var/p
			if(pa.len) world.log << "Command-line parameters:"
			for(p in pa)
			world.log << "[p] = [pa[p]]"
*/
			if(usr.client.dir != direct)
				sleep(5)
				usr.client.dir = direct
				sleep(5)
			..()
		return

	if(!usr.client.mob.S.Engine)
		usr << "Необходимо активировать двигатель."
		return

	if(direct==4||direct==8) Change_Direc(direct)

	if(direct==1||direct==2) Change_Speed(direct)

/*
/client/North() // knopka 8
	usr.client.dir = 1
	..()
/client/South() // knopka 2
	usr.client.dir = 2
	..()
/client/West() // knopka 4
	usr.client.dir = 4
	..()
/client/East() // knopka 6
	usr.client.dir = 8
	..()
/client/Northeast() // knopka 9

/client/Southeast() // knopka 3

/client/Southwest() // knopka 7

/client/Northwest() // knopka 1

/client/Center() // knopka 5
*/

/*
var/list/pa = params2list(params)
*/
/*
world/New()
   var/p
   if(params.len) world.log << "Command-line parameters:"
   for(p in params)
      world.log << "[p] = [params[p]]"
*/

/*
			if(istype(object,/turf) && pa.Find("left") && !pa.Find("alt") && !pa.Find("ctrl") )
*/
mob
	Click(location, control, params)
		world << "[location]"
		world << "[control]"
		world << "[params]"