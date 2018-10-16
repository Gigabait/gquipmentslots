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

if EquipmentSlots.ShowDebugPrints then

	print( "Including EquipmentSlot Meta.")

end

EquipmentSlots.EquipmentDatabase = {};

local _counter = 1;

function EquipmentSlots.RegisterEquipment( tb , type )
	local _Slot = _counter;

	EquipmentSlots.EquipmentDatabase[_Slot] = tb;
	EquipmentSlots.EquipmentDatabase[_Slot].ID = _counter;
	EquipmentSlots.EquipmentDatabase[_Slot].type = type;

	_counter = _counter + 1;
	//EquipmentSlots.EquipmentDatabase = table.ClearKeys( EquipmentSlots.EquipmentDatabase, true )

end 
 
 function EquipmentSlots.GetEquipment( id )

 	return EquipmentSlots.EquipmentDatabase[id]
 
 end
 
 EquipmentSlots.TickingEquipment = {
 	/*
 	{ 
		
 		PL = "STEAMID";
		TI = ID; // Ticking Item
		LT = 0; // Last Tick
		ST = 0; // Start Time
	}
 	*/

 };

if SERVER then
	
	util.AddNetworkString("ReplicateTickingEquipment");

	function EquipmentSlots.ReplicateTickingEquipment( )

		net.Start("ReplicateTickingEquipment")
			net.WriteTable( EquipmentSlots.TickingEquipment );
		net.Broadcast();

	end
	
	function EquipmentSlots.AddTickingEquipment( steamID , equipmentID )

		table.insert( EquipmentSlots.TickingEquipment, { PL = steamID , TI = equipmentID , LT = os.time() , ST = os.time() } )
 		EquipmentSlots.ReplicateTickingEquipment( )
	end

	--function EquipmentSlots.RemoveTickingEquipment( _p , _id )

	--end
	
end

if CLIENT then
	
	net.Receive( "ReplicateTickingEquipment", function( _l , _p )

		local _tb = net.ReadTable();

		EquipmentSlots.TickingEquipment = _tb;

		print("Received Ticking equipment.")

	end )

end  

function EquipmentSlots.TickEquipment()

 	for k , v in pairs( EquipmentSlots.TickingEquipment ) do
 		
 		if v.TI && v.PL then 

 			local _itemToTick = EquipmentSlots.GetEquipment( v.TI )
 			
 			// Remove if we surpassed our time.
 			if _itemToTick.UseLength + v.ST < os.time() then
  				
 				print( "Removed " .. v.TI .. " from " .. v.PL );
 				table.remove( EquipmentSlots.TickingEquipment , k );

 				if SERVER then
 					
 					EquipmentSlots.ReplicateTickingEquipment( )
 				
 				end
 				
 				_itemToTick.FinishedUse( v.PL , v.LT, v.ST )

 			end


			if _itemToTick.UseTick then 
 					
 				_itemToTick.UseTick( v.PL , v.LT, v.ST )
 			
 			end
 				
 			EquipmentSlots.TickingEquipment[k].LT = os.time();
 			
 		end
 			 		
 	end


 end


function EquipmentSlots.StartTickingEquipment()

	 local LastTick = 0;

	 hook.Add( "Think" , "TickEquipment", function()

	 	if LastTick+1 <= os.time() then

	 		EquipmentSlots.TickEquipment();

	 		LastTick = os.time();
	 	end
	 	
	 end )

end

function EquipmentSlots.StopTickingEquipment()

	hook.Remove( "Think" , "TickEquipment" )

end
