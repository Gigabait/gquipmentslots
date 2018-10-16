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

util.AddNetworkString("AttemptGivingEquipmentItem");

net.Receive("AttemptGivingEquipmentItem", function(_l, _p )

	local _id = net.ReadInt( 16 )
	_p:AddItemToEquipmentInv( _id )
	_p:ChatPrint( EquipmentSlots.GetEquipment( _id ).name .. " has been given to you." );
	
end)

local _pMeta = FindMetaTable('Player');

function _pMeta:GetEquipmentInventory( )

	return self:getFlag("EqpInv", {} );

end

//local flgName = (tb == true && "AttrbTb" || "EqpTb")
function _pMeta:GetEquipmentSlots()

	return self:getFlag("EqpTb", {} ) || {};

end

function _pMeta:GetEquipmentSlot( slot )

	local _Equipment = self:GetEquipmentSlots();

	if _Equipment[slot] then
		
		return _Equipment[slot];

	end

	return nil;

end

function _pMeta:EquipItem( equipmentItemID , slot, invSlot )

	local _Item = EquipmentSlots.GetEquipment( equipmentItemID );
	

	local _SlotConfig = EquipmentSlots.config.Slots[slot];

	local _CurrentlyInSlot = self:GetEquipmentSlot( slot );
	local _SlotToInsert = slot;

	local _ItemInSlot = EquipmentSlots.GetEquipment( _CurrentlyInSlot );

	if !_Item then return false end;
	if _Item && _Item.type != slot then return false end
	
	// Something is in the slot
	if _CurrentlyInSlot != nil then

		// We have to find another slot to insert to.
		_SlotToInsert = nil;

		// does the slot have any alternative slots?
		if _SlotConfig.alternatives && _SlotConfig.allowedType && _SlotConfig.allowedTypes[slot] then 

			for k , v in pairs( _SlotConfig.alternatives ) do
				
				if !self:GetEquipmentSlot( v ) then
					
					_SlotToInsert = v;

					break;

				end

			end

		end
		
	end

	// If we dont have an empty slot, just run the un-equip function.
	if _SlotToInsert == nil then 

		local _success = self:UnequipItem( slot );

		if _success then
		
			_SlotToInsert = slot
		
		else
			
			return false;

		end

	end

	
	local _Success = self:RemItemFromEquipmentInv( equipmentItemID, invSlot );
	if _Success != true then 
		print("Couldn't remove item from inventory")
		return false; end
	
	//_Equipment[_SlotToInsert] = ID;
	local _Equipment = self:GetEquipmentSlots();

	_Equipment[_SlotToInsert] = equipmentItemID

	if _ItemInSlot && _ItemInSlot.OnEquip then
		
		_ItemInSlot.OnEquip( self )

	end

	self:setFlag("EqpTb", _Equipment);

	_SlotConfig ,_SlotToInsert , _ItemInSlot, _CurrentlyInSlot, _Success,_Item = nil, nil, nil, nil, nil,nil;
	return true;
end

function _pMeta:UnequipItem( slot )
	
	local _Equipment = self:GetEquipmentSlots();

	local _SlotConfig = EquipmentSlots.config.Slots[slot];

	local _CurrentlyInSlot = self:GetEquipmentSlot( slot );
	local _SlotToRemove = slot;

	if _CurrentlyInSlot != nil then

		local _success = self:AddItemToEquipmentInv( _Equipment[slot] );

		if _success == true then
			
			_Equipment[slot] = nil;
		
		end
		
	end

	self:setFlag("EqpTb", _Equipment);

	local _Item = EquipmentSlots.GetEquipment( _CurrentlyInSlot );

	if _Item.OnDisequip then
		
		_Item.OnDisequip( self )

	end

	// Clear some memory;
	_SlotToRemove,_CurrentlyInSlot,_SlotConfig,_Equipment, _Item = nil,nil,nil,nil,nil;
	
	return true;
end

function _pMeta:AddItemToEquipmentInv( ID )

	local _EquipmentInventory = self:GetEquipmentInventory( );
	
	if !isnumber(ID) then return false end;
	
	table.insert( _EquipmentInventory, ID )

	self:setFlag("EqpInv", _EquipmentInventory);

	return true;
end

function _pMeta:RemItemFromEquipmentInv( ID, slot )

	local _EquipmentInventory = self:GetEquipmentInventory( );

	local _k = table.KeyFromValue( _EquipmentInventory , ID ) || nil;

	if slot && _EquipmentInventory[slot] then
		
		_k = slot;

	end
	
	// we found an instance of the item in the inventory
	if _k != nil then
		
		table.remove( _EquipmentInventory , _k );
		self:setFlag("EqpInv", _EquipmentInventory);

		return true;
	end

	return false;
end
