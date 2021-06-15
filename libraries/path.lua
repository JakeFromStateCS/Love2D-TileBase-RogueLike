path = {};

function path:GetNeighbors( pos )
	local returnNeighbors = {};
	local neighbors = {
		["up"] = vector( pos.x, pos.y - 1 ),
		["down"] = vector( pos.x, pos.y + 1 ),
		["left"] = vector( pos.x - 1, pos.y ),
		["right"] = vector( pos.x + 1, pos.y );
	};

	for dir, vec in pairs( neighbors ) do
		local TILE = tile:GetTile( vec );
		if( TILE ) then
			returnNeighbors[dir] = TILE;
		else
			local TILE = {};
			TILE.pos = vec;
			function TILE:GetPos()
				return self.pos;
			end;
		end;
	end;
	return returnNeighbors;
end;

function path:CalcMoves( startPos, endPos )
	local TILE = TILE:GetTile( startPos );
	if( TILE == nil ) then
		local TILE = {};
		TILE.pos = startPos;
		function TILE:GetPos()
			return self.pos;
		end;
		local openList = { TILE };
		local closedList = {};
		local map = {};

		for k, TILE in pairs( openList ) do
			local pos = TILE:GetPos();
			local neighbors = path:GetNeighbors( pos );

			for dir, TILE2 in pairs( neighbors ) do
				if( TILE2.Name == nil ) then
					local pos = TILE2:GetPos();
					TILE2.Parent = TILE;
					table.insert( openList, TILE2 );
				end;
			end;
			table.remove( openList, k );
		end;
	end;



end;