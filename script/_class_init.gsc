init()
{ 
	//thread onPlayerConnect();
	thread set_class(); 
	thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		
		player thread onPlayerSpawned();
		player thread set_perk();
	}
}

onPlayerSpawned()
{
	for(;;)
	{
		self waittill("spawned_player");
		
		//self thread table();
	}
}

set_class()
{
	level.sg_class = [];
	t = 0;
	
	team = "axis";

	class = "CLASS_JAFFA;1";
	level.sg_class[team][class]["health"] = 200;
	level.sg_class[team][class]["model"] = "body_mp_sas_urban_sniper";
	level.sg_class[team][class]["hands"] = "viewhands_black_kit";
	level.sg_class[team][class]["speed"] = 80;
	level.sg_class[team][class]["perk1"] = "specialty_bulletaccuracy";
	level.sg_class[team][class]["perk2"] = "specialty_armorvest";
	level.sg_class[team][class]["perk3"] = "specialty_fastreload";
	t++;
	
	class = "CLASS_JAFFA;2";
	level.sg_class[team][class]["health"] = 300;
	level.sg_class[team][class]["model"] = "body_mp_sas_urban_sniper";
	level.sg_class[team][class]["hands"] = "viewhands_black_kit";
	level.sg_class[team][class]["speed"] = 200;
	level.sg_class[team][class]["perk1"] = "specialty_rof";
	level.sg_class[team][class]["perk2"] = "specialty_pistoldeath";
	level.sg_class[team][class]["perk3"] = "specialty_explosivedamage";	
	t++;
	
	for(i = 1;i < t+1;i++)
	{
		level.sg_class[team]["CLASS_JAFFA;"+i]["p_weapon"] = "ak47_mp";
		level.sg_class[team]["CLASS_JAFFA;"+i]["s_weapon"] = "usp_mp";
	}
	
}

set_perk()
{
	for(i = 1;i < 3;i++)
	{
		stat = self maps\mp\gametypes\_persistence::statGet( "jaffa_c"+i );
		level.default_perk["CLASS_JAFFA;"+i][0] = get_perk(stat, "axis", "CLASS_JAFFA;"+i);
	}
}

get_perk(stat, team, class)
{
	perk = level.sg_class[team][class]["perk"+stat];
}