/*=====================================================================
== Made by Mario 'Tibba'Sinn 										 ==
== CONTACT: mariosgameroominquiries@gmail.com" 						 ==
== YOUTUBE: https://www.youtube.com/channel/UCVYG2ZDHynAXgYLP6J9hxUg ==
== STEAM: https://steamcommunity.com/profiles/76561198191730261/     ==
=======================================================================
== Please consider subscribing to my youtube channel if you end up   ==
== using this addon.												 ==
=======================================================================
== LICENSE: CC BY-NC 4.0											 ==
== https://creativecommons.org/licenses/by-nc/4.0/ 					 ==
=======================================================================*/
if PlayerAttributes.ShowDebugPrints then

	print( "Including Attribute Config.")

end

PlayerAttributes.config = {};

PlayerAttributes.config.NewPlayerAttributes = {
	["intellect"] = 10,
	["stamina"] = 100,
	["strength"] = 25,
	["agility"] = 25,
	["armor"] = 10,
	["attackpower"] = 100,
	["criticalstrike"] = 2.5,
	["speed"] = 100,
	["versatility"] = 5,
}

PlayerAttributes.config.Attributes = {
	["intellect"] = {
		Max = 1000,// 1 = 0.01% Non Physical Damage
	};
	["stamina"] = {
		Max = 1000,// 1 = 0.01% Resource regeneration
	};
	["vitality"] = {		
		Max = 1000,// 1 = 1000 HP increase
	};
	["strength"] = {
		Max = 1000,// 1 = 0.01% Physical Damage Increase
	};
	["agility"] = {
		Max = 1000,	// 1 = 0.01% Run Speed Increase	
	};
	["haste"] = {
		Max = 50,// 1 = 1% Cast Speed increase
	};
	["leech"] = {
		Max = 40,// 1 = 1% Damage Leeched
	};
	["spirit"] = {
		Max = 100,// 1 = 1 HP's Regenerated		
	};
	["attackpower"] = {
		Max = 1000,// 1000 = 1000% increased damage
	};
	["criticalstrike"] = {
		Max = 1000,// 1000 = 100% increased crit chance
	};
	["speed"] = {
		Max = 1000,// 1 = 0.01% Movement Speed increase
	};
	["parry"] = {
		Max = 100,// 1 = 1% Parry chance for physical attacks
	};
	["block"] = {
		Max = 100,// 1 = 1% Block rating for any damage attacks
	};	
	["armor"] = {
		Max = 7500,// 1 = 0.01% Damage Reduction
	};		
	["multistrike"] = {
		Max = 100,// 1 = 0.1% chance to damage for twice the amount	
	};	
	["versatility"] = {
		Max = 1000,	// 1 = 0.01 increase to HP & 0.1% Increase of damage.
	};
};