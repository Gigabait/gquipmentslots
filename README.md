![alt text](https://raw.githubusercontent.com/TibbaRrule/gquipmentslots/master/gquipmentslotslogo.png)

# gquipmentslots
Garry's mod doesn't support equipment or attributes. This is a skeleton I wrote for my game-mode before integrating, feel free to use under (CC BY-NC 4.0)[https://creativecommons.org/licenses/by-nc/4.0/legalcode] (Full Code)[https://creativecommons.org/licenses/by-nc/4.0/legalcode]

**Workshop Release:** https://steamcommunity.com/sharedfiles/filedetails/?id=1553141102

**Actual Features:**
- Variable Flag Library by Josh Moser
- Modular Attribute System
- Modular Equipment (Armor) System

>How do I add a equipment piece?

A: You have to learn a little bit of my syntax, which is basicly Acecool2.0 with more of a mess. Facepunch would be proud :D
1. (Familiarize yourself with the attributes)[lua/equipmentslots/attributeconfig.lua]
2. (Head to any of the equipment configs)[lua/equipmentslots/equipment/chestconfig.lua]
3. Using this as a guideline, like in DarkRP to create entities or jobs you just add em below the function definition

```
ChestPieces.Add( {
	name = "ChestPieceName";
	attributes = {
		["intellect"] = 1;
		["strength"] = 5;
	};
	Worth = 100;
	UseLength = 30;
	TickUse = false;
	description = "Many sought this very chestpiece as a treasure of fabled times.";
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
```

>How do I spawn equipment in?
A: You can find a list of your equipment items with the +givegquipmentpanel console command (-givegquipmentpanel to close).

>Will you be updating this addon?
A: I am putting it on the workshop, if people subscribe to my (Youtube)[https://www.youtube.com/channel/UCVYG2ZDHynAXgYLP6J9hxUg] channel or something i'll make sure it becomes pretty.
