OBJ = OBJ or {};
OBJ.Name = "Base";
OBJ.Pos = vector( 0, 0 );
OBJ.Color = Color( 255, 255, 255, 255 );
OBJ.Char = "O";


function OBJ:GetPos()
	return self.Pos;
end;

function OBJ:GetChar()
	return self.Char;
end;

function OBJ:GetColor()
	return self.Color;
end;

function OBJ:GetClass()
	return self.Name;
end;

function OBJ:SetPos( vec )
	if( vec.x and vec.y ) then
		local TILE = tile:GetTile( vec );
		if( TILE ) then
			self.Pos = vec;
			TILE:SetObject( self );
		end;
	end;
end;

function OBJ:SetColor( col )
	if( col.r and col.g and col.b ) then
		self.Color = col;
	end;
end;

function OBJ:SetChar( char )
	self.Char = char;
end;

function OBJ:Use()

end;

function OBJ:Collide( ent )

end;

function OBJ:Remove()
	local TILE = tile:GetTile( self:GetPos() );
	if( TILE ) then
		TILE:RemoveObject();
	end;
end;