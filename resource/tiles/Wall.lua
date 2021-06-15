TILE = TILE or {};
TILE.Name = "Wall";
TILE.Base = "Base";
TILE.Pos = vector( 0, 0 );
TILE.Color = Color( 100, 100, 100, 255 );
TILE.Object = nil;
TILE.Passable = false;

function TILE:Collide( ent )
	print( ent.Char );
end;