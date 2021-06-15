file = {};

function file:Find( directory, extension )
	--_files = return table
	--files = all files in directory
	local _files = {};
	local files = love.filesystem.getDirectoryItems( directory );
	for folder,file in pairs( files ) do
		if( extension ~= nil and extension ~= "" and extension ~= "*" ) then
			local _fExtension = string.sub( file, -3 );
			if( string.lower( _fExtension ) == string.lower( extension ) ) then
				table.insert( _files, file );
			end;
		end;
	end;
	return files;
end;

