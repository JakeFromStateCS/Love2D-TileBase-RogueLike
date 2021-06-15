cam = {};
cam.Pos = vector( 0, 0 );

function cam:GetPos()
	return self.Pos;
end;

function cam:SetPos( vec )
	self.Pos = vec;
end;

function cam:GetRenderBounds()
	local pos = self:GetPos();
	local min = vector( pos.x, pos.y );
	local max = vector( pos.x + math.ceil( Base.Config.Resolution.y / Base.Config.TileSize ), pos.y + math.ceil( Base.Config.Resolution.y / Base.Config.TileSize ) );
	return min, max;
end;

function cam:GetRenderPos( vec )
	local pos = self:GetPos();
	local renderX = ( vec.x - 1 ) * Base.Config.TileSize - ( pos.x * Base.Config.TileSize );
	local renderY = ( vec.y - 1 ) * Base.Config.TileSize - ( pos.y * Base.Config.TileSize );
	return vector( renderX, renderY );
end;

function cam:CoordToTile( vec )
	local pos = self:GetPos();
	local actualX = math.ceil( vec.x / Base.Config.TileSize ) + pos.x;
	--math.ceil( ( ( vec.x - Base.Config.TileSize ) + pos.x ) / Base.Config.TileSize ) + 1;
	local actualY = math.ceil( vec.y / Base.Config.TileSize ) + pos.y;
	return vector( actualX, actualY );
end;