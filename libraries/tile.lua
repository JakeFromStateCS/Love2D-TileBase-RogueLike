tile = {};
tile.types = {};
tile.stored = {};


function tile:Loadtiles()
	local files = file:Find( "/resource/tiles", "lua" );
	for _,file in pairs( files ) do
		TILE = {};
			include( "/resource/tiles/" .. file );
			if( TILE.Base ) then
				include( "/resource/tiles/" .. TILE.Base .. ".lua" );
				include( "/resource/tiles/" .. file );
			end;
			if( TILE.Name ) then
				tile.types[TILE.Name] = table.Copy( TILE );
				print( "Base | Tile: Loaded tile - " .. TILE.Name );
			end;
		TILE = nil;
	end;
end;

function tile:GenerateRoom( pos, size )
	for x = pos.x, pos.x + size.x do
		for y = pos.y, pos.y + size.y do
			local TILE = tile:GetTile( vector( x, y ) );
			if( TILE ) then
				return;
			end;
		end;
	end;
	for x = pos.x, pos.x + size.x do
		for y = pos.y, pos.y + size.y do
			if( x == pos.x or x == pos.x + size.x ) then
				local TILE = tile:Create( "Wall" );
				TILE:SetPos( vector( x, y ) );
			elseif( y == pos.y or y == pos.y + size.y ) then
				local TILE = tile:Create( "Wall" );
				TILE:SetPos( vector( x, y ) );
			else
				local TILE = tile:Create( "Floor" );
				TILE:SetPos( vector( x, y ) );
			end;
		end;
	end;
end;

function tile:GenerateChunk( vec )
	--Fill the chunk with wall
	--|======|======|======|======|
	local chunk = vector( math.ceil( vec.x / Base.Config.ChunkSize ), math.ceil( vec.y / Base.Config.ChunkSize ) );
	for x = ( chunk.x - 1 ) * Base.Config.ChunkSize + 1, chunk.x * Base.Config.ChunkSize do
		for y = ( chunk.y - 1 ) * Base.Config.ChunkSize + 1, chunk.y * Base.Config.ChunkSize do
			if( tile:GetTile( vector( x, y ) ) == nil ) then
				




				--local TILE = tile:Create( "Floor" );
				--TILE:SetPos( vector( x, y ) );
			end;
		end;
	end;

	--Generate a room
	--for x = vec.x + 1, vec.x + Base.Config.ChunkSize - 2 do
		--for y = vec.y + 1, vec.y + Base.Config.ChunkSize - 2 do
			--if( tile:GetTile( vector( x, y ) ) == nil ) then
				--local TILE = tile:Create( "Floor" );
				--TILE:SetPos( vector( x, y ) );
			--end;
		--end;
	--end;
end;

function tile:GenerateMap()
	--for x = -500, 500 do
	--	for y = -500, 500 do
	--		local tileType = "Floor";
	--		if( math.random( 1, 20 ) == 1 ) then
	--			local size = vector( math.random( 1, 10 ), math.random( 1, 10 ) );
	--			tile:GenerateRoom( vector( x, y ), size );
	--		else
	--			--local TILE = tile:Create( tileType );
	--			--TILE:SetPos( vector( x, y ) );
	--		end;
	--	end;
	--end;

	for i=-40, 40 do
		local size = vector( math.random( 3, 20 ), math.random( 3, 20 ) );
		local pos = vector( math.random( -20, 10 + 2 * math.sin( i ) * 20 ), math.random( -20, 10 + 2 * math.cos( i ) * 20 ) );
		tile:GenerateRoom( pos, size );
	end;
end;

function tile:Create( type )
	if( tile.types[type] ) then
		return table.Copy( tile.types[type] );
	end;
end;

function tile:GetTile( vec )
	if( tile.stored[vec.x] ) then
		if( tile.stored[vec.x][vec.y] ) then
			return tile.stored[vec.x][vec.y];
		end;
	end;
end;

function tile:DrawTiles()
	local min, max = cam:GetRenderBounds();
	for x = min.x, max.x do
		if( tile.stored[x] ) then
			for y = min.y, max.y do
				local TILE = tile.stored[x][y];
				if( TILE ) then
					if( TILE.Draw ) then
						TILE:Draw();
					else
						local col = TILE:GetColor();
						local renderPos = cam:GetRenderPos( vector( x, y ) );
						surface.SetDrawColor( col );
						surface.DrawRect( renderPos.x, renderPos.y, Base.Config.TileSize, Base.Config.TileSize );
					end;
					if( TILE:GetObject() ) then
						local OBJ = TILE:GetObject();
						if( OBJ ) then
							if( OBJ.Draw ) then
								OBJ:Draw();
							else
								local col = OBJ:GetColor();
								local char = OBJ:GetChar();
								local renderPos = cam:GetRenderPos( vector( x, y ) );
								surface.SetDrawColor( col );
								surface.SetTextSize( 12 );
								surface.DrawText( renderPos.x + 1, renderPos.y - 1, char );
							end;
						end;
					end;
				else
					--tile:GenerateChunk( vector( x, y ) );
				end;
			end;
		else
			--tile:GenerateChunk( vector( x, min.y ) );
		end;
	end;
end;
hook.Add( "TileDraw", "tile.DrawTiles", tile.DrawTiles );

function tile.MousePressed( x, y, button )
	if( button == "l" ) then
		local TILE = tile:Create( "Floor" );
		local pos = cam:CoordToTile( vector( x, y ) );
		print( "Click: ", pos );
		TILE:SetPos( pos );
	elseif( button == "r" ) then
		local TILE = tile:Create( "Wall" );
		local pos = cam:CoordToTile( vector( x, y ) );
		print( "Click: ", pos );
		TILE:SetPos( pos );
	else
		local pos = cam:CoordToTile( vector( x, y ) );
		local TILE = tile:GetTile( pos );
		if( TILE ) then
			local OBJ = object:Create( "Waffle" );
			if( OBJ ) then
				OBJ:SetPos( pos );
			end;
		end;
	end;
end;
hook.Add( "MousePressed", "tile.MousePressed", tile.MousePressed );

tile:Loadtiles();

tile:GenerateMap();