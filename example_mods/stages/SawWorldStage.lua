local spinstuff = 0
local f = 0

function onCreate()
	makeLuaSprite('BackWorld', 'saw/sawWorld/BackWorld', -3000, -1000)
	setScrollFactor('BackWorld', 0.1, 0.1)
	scaleObject('BackWorld', 3, 3)
	
	makeLuaSprite('RocksWorld', 'saw/sawWorld/RocksWorld', -600, -300)
	setScrollFactor('RocksWorld', 0.1, 0.1)

	makeLuaSprite('FloorWorld', 'saw/sawWorld/FloorWorld', -1200, -600)
	scaleObject('FloorWorld', 1.5, 1.5)

	addLuaSprite('BackWorld', false)
	addLuaSprite('RocksWorld', false)
	addLuaSprite('FloorWorld', false)
end

function onUpdate()
	scaleObject('blammedLightsBlack', 3, 3)--i dont find a way to fix it

	songPos = getSongPosition()
	currentBeat = (songPos/1000)

	spinstuff = spinstuff + 1

	doTweenAngle('spinLol', 'BackWorld', spinstuff, 0.01, 'linear')

	doTweenY('rockfloat', 'RocksWorld', -300 - 700*math.sin((currentBeat+1*0.1)*math.pi), 6)
end

function onStepHit()
    if not lowQuality then
        Particle()
    end
end

function Particle()
songPos = getSongPosition()
currentBeat = (songPos/100)
  f = f + 1
  sus = math.random(1, 9000)
  makeLuaSprite('part' .. f, 'saw/sawWorld/particles', math.random(-300, 1800), 1100)
  doTweenY(sus, 'part' .. f, -900*math.tan((currentBeat+1*0.1)*math.pi), 6)
  
  addLuaSprite('part' .. f, true)
  if f >= 50 then
  f = 1
  end
end