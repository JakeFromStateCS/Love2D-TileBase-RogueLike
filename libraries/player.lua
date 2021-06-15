player = {};
player.Pos = vector( 0, 0 );
player.Color = Color( 255, 100, 0, 255 );
player.Char = "@";

function player:GetColor()
	return self.Color;
end;

function player:GetPos()
	local pos = cam:CoordToTile( vector( ScrW() / 2 + 12, ScrH() / 2 + 12 ) );
	return pos;
end;

function player:SetPos( vec )
	cam:SetPos( vec );
end;

function player:GetChar()
	return self.Char;
end;

function player:SetColor( col )
	if( col.r and col.g and col.b ) then
		self.Color = col;
	end;
end;

function player:SetChar( char )
	self.Char = char;
end;

function player:CanMove( vec )
	local pos = self:GetPos();
	local TILE = tile:GetTile( pos + vec );
	if( TILE ) then
		if( TILE.Passable ) then
			return true;
		end;
	end;
	return false;
end;

function player.KeyPressed( key, unicode )
	local vec = {
		["w"] = vector( 0, -1 ),
		["s"] = vector( 0, 1 ),
		["a"] = vector( -1, 0 ),
		["d"] = vector( 1, 0 )
	};
	if( vec[key] ) then
		local pos = cam:GetPos();
		local canMove = player:CanMove( vec[key] );
		if( canMove ) then
			player:SetPos( pos + vec[key] );
		else
			local TILE = tile:GetTile( player:GetPos() + vec[key] );
			if( TILE ) then
				if( TILE.Collide ) then
					TILE:Collide( player );
				end;
			end;
		end;
	elseif( key == "e" ) then
		local TILE = tile:GetTile( player:GetPos() );
		if( TILE ) then
			local OBJ = TILE:GetObject();
			if( OBJ ) then
				if( OBJ.Use ) then
					OBJ:Use();
				end;
			end;
		end;
	end;
end;
hook.Add( "KeyPressed", "player.KeyPressed", player.KeyPressed );

function player:Draw()
	local col = player:GetColor();
	local char = player:GetChar();
	surface.SetDrawColor( col );
	surface.SetTextSize( 12 );
	surface.DrawText( ScrW() / 2 - 1, ScrH() / 2 - 1, char );
end;
hook.Add( "PlayerDraw", "player.Draw", player.Draw );