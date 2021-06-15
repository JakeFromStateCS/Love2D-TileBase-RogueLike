local PANEL = {};
PANEL.Size = {
	w = 10,
	h = 10
};
PANEL.Pos = {
	x = 0,
	y = 0
};


function PANEL:Init()
	self.Visible = true;
end;

function PANEL:GetParent()
	return self.Parent;
end;

function PANEL:SetParent( panel )
	self.Parent = panel;
end;

function PANEL:SetSize( w, h )
	self.Size.w = w;
	self.Size.h = h;
end;

function PANEL:SetPos( x, y )
	self.Pos.x = x;
	self.Pos.y = y;
end;

function PANEL:GetPos()
	return self.Pos;
end;

function PANEL:GetSize()
	return self.Size;
end;

function PANEL:MousePressed( x, y, button )
	print( "WE DID IT!" );
end;

function PANEL:Paint( x, y, w, h )
	surface.SetDrawColor( Color( 255, 0, 0 ) );
	surface.DrawRect( x, y, w, h );
end;
vgui.Register( "Base", PANEL );