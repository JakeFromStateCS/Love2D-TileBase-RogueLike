Base = {};

function include( filePath )
	local loaded, chunk = pcall( love.filesystem.load, filePath );
	if( loaded == true ) then
		pcall( chunk );
	else
		print( filePath );
		print( loaded, chunk );
	end;
end;

Base.Include = include;

function includeCoreFiles()
	local files = love.filesystem.getDirectoryItems( "/core" );
	for _,file in pairs( files ) do
		include( "core/" .. file );
		if( Base.Config.Debug ) then
			print( "Base | Loaded Core File: " .. file );
		end;
	end;
end;

function includeLibraries()
	local files = love.filesystem.getDirectoryItems( "/libraries" );
	for _,file in pairs( files ) do
		include( "libraries/" .. file );
		if( Base.Config.Debug ) then
			print( "Base | Loaded Library: " .. file );
		end;
	end;
end;

function love.load()
	include( "config.lua" );
	includeCoreFiles();
	includeLibraries();
	love.window.setMode( Base.Config.Resolution.x, Base.Config.Resolution.y );
end;

function love.mousepressed( x, y, button )
	hook.CallHooks( "MousePressed", { x, y, button } );
end;

function love.keypressed( key, unicode )
	hook.CallHooks( "KeyPressed", { key, unicode } );
end;

function love.keyreleased( key, unicode )
	hook.CallHooks( "KeyReleased", { key, unicode } );
end;

function love.draw()
	hook.CallHooks( "PreTileDraw" );
	hook.CallHooks( "TileDraw" );
	hook.CallHooks( "PostTileDraw" );
	hook.CallHooks( "EntDraw" );
	hook.CallHooks( "PlayerDraw" );
	hook.CallHooks( "HUDPaint" );
	hook.CallHooks( "VGUIPaint" );
	love.window.setTitle( "Base | " .. love.timer.getFPS() .. " FPS" );
end;

function love.update( dt )
	if( time ) then
		time.UpdateTime( dt );
	end;
	hook.CallHooks( "Think", { dt } );
end;