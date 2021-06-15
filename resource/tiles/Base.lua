TILE = TILE or {};
TILE.Name = "Base";
TILE.Pos = vector( 0, 0 );
TILE.Color = Color( 255, 255, 255, 255 );
TILE.Object = nil;
TILE.Passable = true;

function TILE:GetPos()
	return self.Pos;
end;

function TILE:GetObject()
	return self.Object;
end;

function TILE:GetColor()
	return self.Color;
end;

function TILE:GetClass()
	return self.Name;
end;

function TILE:SetPos( vec )
	if( vec.x and vec.y ) then
		if( tile.stored[vec.x] == nil ) then
			tile.stored[vec.x] = {};
		end;
		tile.stored[vec.x][vec.y] = self;
	end;
end;

function TILE:SetColor( col )
	if( col.r and col.g and col.b ) then
		self.Color = col;
	end;
end;

function TILE:SetObject( obj )
	self.Object = obj;
end;

function TILE:RemoveObject()
	self.Object = nil;
end;

function TILE:Use()

end;

function TILE:Collide( ent )

end;