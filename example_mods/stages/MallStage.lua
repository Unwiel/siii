function onCreate()
	-- background shit
	makeLuaSprite('bg', 'saw/MallBack', -350, -100);	
	scaleObject('bg', 2.5, 2.5);
	addLuaSprite('bg', false);
end

function onUpdate()
	scaleObject('blammedLightsBlack', 4, 4)
end