object = {};
object.types = {};
object.stored = {};


function object:LoadObjects()
	OBJ = {};
	local files = file:Find( "/resource/objects", "lua" );
	for _,file in pairs( files ) do
		include( "/resource/objects/" .. file );
		if( OBJ.Base ) then
			include( "/resource/objects/" .. OBJ.Base .. ".lua" );
			include( "/resource/objects/" .. file );
		end;
		if( OBJ.Name ) then
			object.types[OBJ.Name] = table.Copy( OBJ );
			print( "Base | Object: Loaded Object - " .. OBJ.Name );
		end;
		OBJ = nil;
	end;
	OBJ = nil;
end;

function object:GetObject( vec )
	local TILE = tile:GetTile( vec );
	if( TILE ) then
		local OBJ = TILE:GetObject();
		if( OBJ ) then
			return OBJ;
		end;
	end;
end;

function object:Create( type )
	if( object.types[type] ) then
		return table.Copy( object.types[type] );
	end;
end;

object:LoadObjects();