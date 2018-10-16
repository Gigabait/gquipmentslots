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
if EquipmentSlots.ShowDebugPrints then

	print( "Including EquipmentSlot Config.")

end

EquipmentSlots.config = {};
EquipmentSlots.config.Slots = {
	[1]	= {
		prettyname = "Head";
		typename = "Head";
		name = "head";
		allowedTypes = { "head" };
	};
	[2]	= {
		prettyname = "Shoulder";
		typename = "Shoulder";
		name = "shoulder";
		allowedTypes = { "shoulder" };
	};
	[3]	= {
		prettyname = "Chest";
		typename = "Chest";
		name = "chest";
		allowedTypes = { "chest" };
	};
	[4]	= {
		prettyname = "Legs";
		typename = "Legs";
		name = "legs";
		allowedTypes = { "legs" };
	};
	[5]	= {
		prettyname = "Feet";
		typename = "Feet";
		name = "feet";
		allowedTypes = { "feet" };
	};
	[6]	= {
		prettyname = "Wrists";
		typename = "Wrists";
		name = "wrists";
		allowedTypes = { "wrists" };
	};
	[7]	= {
		prettyname = "Ring 1";
		typename = "Ring";
		name = "ring_1";
		allowedTypes = { "ring" };
		alternatives = { 8 };
	};
	[8]	= {
		prettyname = "Ring 2";
		typename = "Ring";
		name = "ring_2";
		allowedTypes = { "ring" };
		alternatives = { 7 };
	};	
	[9]	= {
		prettyname = "Trinket 1";
		typename = "Trinket";
		name = "trinket_1";
		allowedTypes = { "trinket" };
		alternatives = { 10 };
	};
	[10]	= {
		prettyname = "Trinket 2";
		typename = "Trinket";
		name = "trinket_2";
		allowedTypes = { "trinket" };
		alternatives = { 9 };
	};	
	[11]	= {
		prettyname = "Gloves";
		typename = "Gloves";
		name = "gloves";
		allowedTypes = { "gloves" };
	};
	[12]	= {
		prettyname = "Necklace";
		typename = "Necklace";
		name = "neck";
		allowedTypes = { "neck" };
	};
};

EquipmentSlots.config.EquipmentTypes = {
	"head", 
	"shoulder",
	"chest",
	"legs",
	"feet",
	"wrists",
	"ring",
	"trinket",
	"gloves",
	"neck",
}