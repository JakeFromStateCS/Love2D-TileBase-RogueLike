function ScrW()
	return Base.Config.Resolution.y;
end;

function ScrH()
	return Base.Config.Resolution.x;
end;

function table.Copy( tab )
	local TABLE = {};
	for k,v in pairs( tab ) do
		if( type( v ) == "table" ) then
			TABLE[k] = {};
			for index,value in pairs( v ) do
				TABLE[k][index] = value;
			end;
		else
			TABLE[k] = v;
		end;
	end;
	return TABLE;
end;
