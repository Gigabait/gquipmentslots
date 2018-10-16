/*=====================================================================
== Made by Mario 'Tibba'Sinn 										 ==
== CONTACT: mariosgameroominquiries@gmail.com" 						 ==
== YOUTUBE: https://www.youtube.com/channel/UCVYG2ZDHynAXgYLP6J9hxUg ==
== STEAM: https://steamcommunity.com/profiles/76561198191730261/     ==
=======================================================================
== Please consider _subscribing to my youtube channel if you end up   ==
== using this addon.												 ==
=======================================================================
== LICENSE: CC BY-NC 4.0											 ==
== https://creativecommons.org/licenses/by-nc/4.0/ 					 ==
=======================================================================*/
local _Frame

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

local function GiveItemPanelCreate()
	
	_Frame = vgui.Create("D_Frame")
	_Frame:SetSize((ScrW() * 0.5) * _wMod , _hMod*(ScrH() * 0.5))
	_Frame:Center()
	_Frame:SetTitle("Spawnlist")
	_Frame:ShowCloseButton(false)
		LocalPlayer():setFlag("restrictInv", true)
	function _Frame:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false)
	end
	
	_Frame.List = vgui.Create("DPanelList", _Frame)
	_Frame.List:StretchToParent(5, 27, 5, 5)
	_Frame.List:EnableVerticalScrollbar(true)
	_Frame.List:EnableHorizontal(false)
	local _ItemsToList = {
		slots = {


		}
	}
	for k , v in pairs(EquipmentSlots.EquipmentDatabase) do
	
		if !_ItemsToList.slots[v.type] then

			-- iterate through the alternatives
			-- delete the higher one from the list 
			_ItemsToList.slots[v.type] = {}
		end
		local _v = v;
		_v.ID = k;

		table.insert( _ItemsToList.slots[_v.type] , _v );

	end
	local _lists = {}
	local _counter = 1;

	local function FindSlotName( slot ) 

		if EquipmentSlots.config.Slots[slot] then

			return EquipmentSlots.config.Slots[slot];

		end

		return nil;
	end

	for k , v in pairs( _ItemsToList.slots ) do
		
		local _DLabel = vgui.Create( "_DLabel", Panel )
		//_DLabel:SetPos( 40, 40 )

		_DLabel:SetText( _Name || "" )
		_Frame.List:AddItem(_DLabel);

		_subList = vgui.Create("DPanelList", _Frame)
		_subList:SetSize( _Frame:GetWide() - 10 , 155 * _hMod)
		_subList:EnableVerticalScrollbar(true)
		_subList:EnableHorizontal(true)
		_subList.SlotType = k
		_Frame.List:AddItem(_subList);
		_lists[k] = _subList;

	end

	for i=1,#_ItemsToList.slots do
		
		for k , v in pairs( _ItemsToList.slots[i] ) do

			local _sub = vgui.Create("DPanel")
			_sub:SetSize(150,150)
			_sub.Paint = function()
				surface.SetDrawColor(Color(100, 100, 100, 255))
				surface.DrawRect(2, 2, _sub:GetWide() - 4, _sub:GetTall() - 4)
				
				surface.SetTextColor(Color(255, 255, 255, 255))
				surface.SetFont("Default")
				local x, y = surface.GetTextSize( v.name )
				
				surface.SetTextPos(5, 5)
				surface.DrawText( v.name )
			end
			
			_sub.spawnicon = vgui.Create("DButton", _sub)
			_sub.spawnicon:SetPos(10, 20)
			_sub.spawnicon:SetSize( 130, 115)
			_sub.spawnicon.DoClick = function()
			
				net.Start("AttemptGivingEquipmentItem")
					net.WriteInt( v.ID , 16 )
				net.SendToServer()
				
			end
			_lists[v.type]:AddItem(_sub)

		end
		
	end
	
end

concommand.Add("+givequipmentpanel", function() if(not game.SinglePlayer() and not LocalPlayer():IsSuperAdmin()) then return end
	if(_Frame) then _Frame:Remove() 
		LocalPlayer():setFlag("restrictInv", false) end GiveItemPanelCreate() _Frame:MakePopup() _Frame:SetVisible(true) end)
concommand.Add("-givequipmentpanel", function() if(not game.SinglePlayer() and not LocalPlayer():IsSuperAdmin()) then return end
	_Frame:SetVisible(false)
		LocalPlayer():setFlag("restrictInv", false) end)
