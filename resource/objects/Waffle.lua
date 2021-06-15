OBJ = OBJ or {};
OBJ.Base = "Base";
OBJ.Name = "Waffle";
OBJ.Pos = vector( 0, 0 );
OBJ.Color = Color( 255, 0, 0, 255 );
OBJ.Char = "#";

function OBJ:Use()
	print( "You eat a waffle. Yum, waffles." );
	self:Remove();
end;