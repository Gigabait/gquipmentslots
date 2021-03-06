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

	print( "Including EquipmentSlot Shoulder config.")

end

local ShoulderPieces = ShoulderPieces || {};
ShoulderPieces.Database = {};

function ShoulderPieces.Add( item )

	ShoulderPieces.Database[#ShoulderPieces.Database+1] = item;

end

ShoulderPieces.Add( {
	name = "Mario's Sturdy Spraulders";
	attributes = {
		["strength"] = 5;
	};
	Worth = 75;
	UseLength = 30;
	TickUse = false;
	description = "Many sought these shoulderpieces as a treasure of fabled times.";
	OnUse = function( _p, equipmentID )
  
		if SERVER then
			
			EquipmentSlots.AddTickingEquipment(  _p:SteamID() , equipmentID )
	
		end
		
	end;
	UseTick = function( _p, lastTick, firstStart )

	end;
	FinishedUse = function( _p , lastTick , firstStart )

	end;
	OnEquip = function( _p )

	end;
	OnDisequip = function( _p )

	end;
})

/*
FeetPieces.Add( {
	name = "";
	attributes = {
		["intellect"] = 1;
		["strength"] = 5;
	};
	description = "Many sought this very as a treasure of fabled times.";
	OnUse = function( _p )

	end;
})
*/

hook.Add( "InitializeEquipment", "RegisterShoulderPieces", function( currentEquipment )

	for k , v in pairs( ShoulderPieces.Database ) do
		
		if EquipmentSlots.ShowDebugPrints then
			
			print("Registering: " .. v.name );

		end
		
		EquipmentSlots.RegisterEquipment( v, 2);

	end

end )