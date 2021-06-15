timer = {};
timer.stored = {};

function timer.Create( name, delay, reps, callFunc )
	if( Base.Config.Debug ) then
		print( "Base - Timer | Creating Timer: " .. name );
	end;
	timer.stored[name] = {
		insertTime = os.time(),
		delay = delay,
		reps = reps,
		ranReps = 0,
		callFunc = callFunc
	};
end;

function timer.Simple( delay, callFunc )
	local name = "timer_" .. ( #timer.stored + 1 );
	timer.Create( name, delay, 1, callFunc );
end;

function timer.Destroy( name )
	if( Base.Config.Debug ) then
		print( "Base - Timer | Destroying Timer: " .. name );
	end;
	timer.stored[name] = nil;
end;

function timer.RunTimers()
	for name,timerTab in pairs( timer.stored ) do
		if( os.time() > timerTab.insertTime + timerTab.delay ) then
			if( Base.Config.Debug ) then
				print( "Base - Timer | Calling Timer: " .. name );
			end;
			timerTab.callFunc();
			timerTab.ranReps = timerTab.ranReps + 1;
			timerTab.insertTime = os.time();
			if( timerTab.ranReps == timerTab.reps ) then
				timer.Destroy( name );
			end;
		end;
	end;
end;
hook.Add( "Think", "timer.RunTimers", timer.RunTimers );