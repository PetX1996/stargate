init()
{ 
	thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		
		player thread onPlayerSpawned();
		//self thread table();
	}
}

onPlayerSpawned()
{
	for(;;)
	{
		self waittill("spawned_player");
		
		self thread table();
	}
}

table()
{
	self maps\mp\gametypes\_persistence::statadd(  "jaffa_c1" ,1);
	self maps\mp\gametypes\_persistence::statset(  "jaffa_c1" ,1);
	self maps\mp\gametypes\_persistence::statadd(  "jaffa_c2" ,1);
	self maps\mp\gametypes\_persistence::statset(  "jaffa_c2" ,1);
	
	self script\_class_init::set_perk();
	
	Value = self maps\mp\gametypes\_persistence::statGet(  "axis_class4" );
	iprintln("stat: "+value);
	
	for(;;)
	{
		for(i = 0;i < 4;i++)
		{
			wait 1;
			
			Value = self maps\mp\gametypes\_persistence::statGet(  "axis_class4" );
			self iprintln("stat: "+value);
		}
		
		self maps\mp\gametypes\_persistence::statSet(  "axis_class4", 2 );
		
		for(i = 0;i < 4;i++)
		{
			wait 1;
			
			Value = self maps\mp\gametypes\_persistence::statGet( "axis_class4" );
			self iprintln("stat: "+value);
		}
		
		self maps\mp\gametypes\_persistence::statSet( "axis_class4", 3  );		
	}
}