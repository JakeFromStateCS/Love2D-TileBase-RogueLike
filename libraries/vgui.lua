vgui = {};
vgui.types = {};
vgui.objects = {};

print( "Loading VGUI" );
function vgui.LoadFiles()
	print( "Base | LOADING VGUI" );
	local files = file:Find( "/resource/vgui", "lua" );
	for _,file in pairs( files ) do
		print( file );
		PANEL = {};
		local fileName = string.sub( file, 1, string.len( file ) - 4 )
			include( "/resource/vgui/" .. file );
			if( PANEL.Base ) then
				include( "/resource/vgui/" .. PANEL.Base .. ".lua" );
				include( "/resource/vgui/" .. file );
			end;
			print( "Base | Loaded VGUI: " .. fileName );
		PANEL = nil;
	end;
end;

function vgui.Register( name, panel )
	vgui.types[name] = table.Copy( panel );
end;

function vgui.Create( name, parent )
	local panel = {};
	local basePanel = vgui.types[name];
	for k,v in pairs( basePanel ) do
		panel[k] = v;
	end;
	if( panel ) then
		if( parent ) then
			panel:SetParent( parent );
		end;
		table.insert( vgui.objects, panel );
		if( panel.Init ) then
			panel:Init();
		end;
	end;
	return panel;
end;

function vgui.MousePressed( x, y, button )
	local topObj = 0;
	for index,panel in pairs( vgui.objects ) do
		local pos = panel:GetPos();
		local size = panel:GetSize();
		if( x > pos.x and x <= pos.x + size.w ) then
			if( y > pos.y and y <= pos.y + size.h ) then
				if( index > topObj ) then
					topObj = index;
				end;
			end;
		end;
	end;
	local panel = vgui.objects[topObj];
	if( panel ) then
		if( panel.MousePressed ) then
			panel:MousePressed( x, y, button );
		end;
	end;
end;
hook.Add( "MousePressed", "vgui.MousePressed", vgui.MousePressed );

function vgui.VGUIPaint()

	for index,panel in pairs( vgui.objects ) do
		if( panel.Paint ) then
			local pos = panel:GetPos();
			local size = panel:GetSize();
			local parent = panel:GetParent();
			if( parent ) then
				local parentPos = parent:GetPos();
				x = x + parentPos.x;
				y = y + parentPos.y;
			end;
			panel:Paint( pos.x, pos.y, size.w, size.h );
		end;
	end;
end;
hook.Add( "VGUIPaint", "vgui.VGUIPaint", vgui.VGUIPaint );

function vgui.Think()
	for index,panel in pairs( vgui.objects ) do
		if( panel.Think ) then
			panel:Think();
		end;
	end;
end;
hook.Add( "Think", "vgui.Think", vgui.Think );



vgui.LoadFiles();
local panel = vgui.Create( "Base" );
panel:SetPos( 50, 50 );
panel:SetSize( 100, 100 );