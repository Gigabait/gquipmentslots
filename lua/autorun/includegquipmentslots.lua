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
 
EquipmentSlots = EquipmentSlots || {};
PlayerAttributes = PlayerAttributes || {};

EquipmentSlots.ShowDebugPrints = false;
PlayerAttributes.ShowDebugPrints = false;

if EquipmentSlots.ShowDebugPrints || PlayerAttributes.ShowDebugPrints then

	print( "Including EquipmentSlot Files.")

end

if SERVER then

	AddCSLuaFile( "ext/flagsnwlib.lua")
	include( "ext/flagsnwlib.lua" )

	// Load Serverside Scripts
	for k,v in pairs(file.Find("equipmentslots/sv/*.lua", "LUA")) do
		include( "equipmentslots/sv/" .. v )

	end

	// Load Clientside Scripts
	for k,v in pairs(file.Find("equipmentslots/cl/*.lua", "LUA")) do
		AddCSLuaFile( "equipmentslots/cl/" .. v )

	end

	// Load Shared Scripts
	for k,v in pairs(file.Find("equipmentslots/*.lua", "LUA")) do
		AddCSLuaFile( "equipmentslots/" .. v )
		include( "equipmentslots/" .. v )
	end


	// Load Shared Scripts
	for k,v in pairs(file.Find("equipmentslots/equipment/*.lua", "LUA")) do
		AddCSLuaFile( "equipmentslots/equipment/" .. v )
		include( "equipmentslots/equipment/" .. v )
	end

end 

if CLIENT then

	include( "ext/flagsnwlib.lua" )

	// Load Clientside Scripts
	for k,v in pairs(file.Find("equipmentslots/cl/*.lua", "LUA")) do
		include( "equipmentslots/cl/" .. v )

	end

	// Load Shared Scripts
	for k,v in pairs(file.Find("equipmentslots/*.lua", "LUA")) do
		
		include( "equipmentslots/" .. v )

	end

	// Load Shared Scripts
	for k,v in pairs(file.Find("equipmentslots/equipment/*.lua", "LUA")) do
		include( "equipmentslots/equipment/" .. v )
	end

end


hook.Run( "InitializeEquipment");
EquipmentSlots.StartTickingEquipment()