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

	print( "Including EquipmentSlot Implementation.")

end

EquipmentSlots.system = {};

hook.Add("Equipment_Retrieval" , "ReceiveEquipment", function( _success, _rows , _steamID )

	print( "_success: " .. _success )
	PrintTable( _rows )
	print( "_steamID: " .. _steamID )

end )

hook.Add( "Saved_Equipment", "SavedEquipment" , function( _steamID , _success , _newRow, _failedMainQuery )

	if _success == true then
		
		if _newRow then
			

		end	

	else

		if _failedMainQuery then
			


		end

	end

end)

function EquipmentSlots.system.LoadPlayerAttributes( ID )
	PlayerAttributes.Database:RetrievePlayerData( ID, true )
end

function EquipmentSlots.system.SavePlayerAttributes( ID )
	PlayerAttributes.Database:SavePlayerData( ID , true )
end