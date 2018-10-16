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
if PlayerAttributes.ShowDebugPrints && EquipmentSlots.ShowDebugPrints then

	print( "Including Filesystem Implementation.")

end

require("mysqloo");

local DBInfo = {
	Site 	 = "rotospacest.site.nfoservers.com";
	UserName = "rotospacest";
	Password = "3EuW43fYBR";
	DB_Name	 = "rotospacest_ea";
}

// Retrieves from this IP & the following tables IP's!
local RelevantIPs = {
}

// Name: GetIPAddressIncludeString()
// Purpose: Makes a string of all IP addresses we should consider while loading (allows you to combine multiple server's tags)
// Arguments: /
// Returns: str (string)
local function GetIPAddressIncludeString()

	local str = "WHERE `IP`='"..game.GetIPAddress() .. "'";

	for k , v in pairs( RelevantIPs ) do
		
		str = str .. " OR `IP`='" .. v .. "'"; 

	end

	return str;

end

local DB = mysqloo.connect( DBInfo.Site , DBInfo.UserName , DBInfo.Password , DBInfo.DB_Name, 3306 )

function DB:onConnected()

    local q = self:query( "SELECT 5+5" )
    function q:onSuccess( data )

        //print( "DB Has connected!" )
        //PrintTable( data )
        PlayerAttributes.Database = DB;
        EquipmentSlots.Database = DB;
    end

    function q:onError( err, sql )

        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )
        PlayerAttributes.Database = nil;
        EquipmentSlots.Database = nil;

    end

    q:start()

end

function DB:onConnectionFailed( err )
 
    print( "Connection to database failed!" )
    print( "Error:", err )

end

function DB:RetrievePlayerData( ID, tb  )

	local tb = (tb == true && "Attributes" || "Equipment")
	local _Q = ObjectTags.Database:query( "SELECT * FROM `" .. tb .. "` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. ID .."';" );
	local _Data = nil;

	function _Q:onSuccess( rows )

		hook.Call( tb .. "_Retrieval" , true ,rows, ID );
		
	end
	
    function _Q:onError( err, sql )

        print( "Query:", sql )
        print( "Error:", err )

		hook.Call( tb .. "_Retrieval" , false ,rows, ID );

    end 
	
	_Q:start();

end

function DB:SavePlayerData( ID , tb )

	local tbName = (tb == true && "Attributes" || "Equipment")
	local rwName = (tb == true && "AttributeData" || "EquipmentData")
	local flgName = (tb == true && "AttrbTb" || "EqpTb")

	if istable( ID ) then

		for k , v in pairs( ID ) do	

			local MainQuery = DB:query( "SELECT * FROM `" .. tbName .. "` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. v .."';" );
			local _Data = nil;

			function MainQuery:onSuccess( rows )
				//PrintTable( rows )
					
				if !rows[1] then 
						
						local _p = player.GetBySteamID( v );

						if _p && IsValid( _p ) && _p:IsPlayer() then
							
							local _Q = DB:prepare( "INSERT INTO `" .. tbName .. "` (`IP`,`SteamID`,`" .. rwName .."`) VALUES (?, ?, ? );" )

							_Q:setString( 1, game.GetIPAddress() )
							_Q:setString( 2, v)
							_Q:setString( 3, util.TableToJSON( _p:getFlag( flgName , {}) ))
							function _Q:onSuccess( data )
								
								hook.Run( "Saved_" .. tbName , v ,true, true )

							end
							
						    function _Q:onError( err, sql )

						        print( "Query:", sql )
						        print( "Error:", err )
								hook.Run( "Saved_" .. tbName , ID ,false, false,false )

						    end
							
							_Q:start();					


						end

					
				else

					local _Q = DB:query( "UPDATE " .. tbName .. " SET " .. rwName .. "='".. util.TableToJSON( _p:getFlag(flgName, {}) ).. "' WHERE SteamID = '" .. v .."' AND IP='".. game.GetIPAddress() .. "';")

					function _Q:onSuccess( data )

						hook.Run( "Saved_" .. tbName , v ,true, false )

					end
							
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )				        
						hook.Run( "Saved_" .. tbName , ID ,false, false, false )

				    end
							
					_Q:start();	
				
				end

			end
							

		    function MainQuery:onError( err, sql )

		        print( "Query:", sql )
		        print( "Error:", err )
				hook.Run( "Saved_" .. tbName , ID ,false, false, true )

		    end
			
			MainQuery:start()

		end
	
	else

		local _p = player.GetBySteamID( ID );

		if _p && IsValid( _p ) && _p:IsPlayer() then
						
			local MainQuery = DB:query( "SELECT * FROM `" .. tbName .. "` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. ID .."';" );

			function MainQuery:onSuccess( rows )
				//PrintTable( rows )
				
				if !rows[1] then 
					
					local _Q = DB:prepare( "INSERT INTO `" .. tbName .. "` (`IP`,`SteamID`,`" .. rwName .."`) VALUES (?, ?, ? );" )
									
				
					_Q:setString( 1, game.GetIPAddress() )
					_Q:setString( 2, ID)
					_Q:setString( 3, util.TableToJSON( _p:getFlag( flgName , {}) ))
					function _Q:onSuccess( data )

						hook.Run( "Saved_" .. tbName , ID ,true, true )

					end
					
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )
						hook.Run( "Saved_" .. tbName , ID ,false, false, false )

				    end
					
					_Q:start();					

				else

					local _Q = DB:query("UPDATE " .. tbName .. " SET " .. rwName .. "='".. util.TableToJSON( _p:getFlag(flgName, {}) ).. "' WHERE SteamID = '" .. ID .."' AND IP='".. game.GetIPAddress() .. "';" )

					function _Q:onSuccess( data )

						hook.Run( "Saved_" .. tbName , ID ,true, false )
					end
							
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )

						hook.Run( "Saved_" .. tbName , ID ,false, false, false )
				    end
							
					_Q:start();	

				end
				
			end
			
		    function MainQuery:onError( err, sql )

		        print( "Query:", sql )
		        print( "Error:", err )
				hook.Run( "Saved_" .. tbName , ID ,false, false, true )

		    end

			MainQuery:start();

		end
		
	end

	return false;
end

DB:connect()