local thething = false
local angle = 100

function onUpdatePost(elapsed)
    local songPos = getSongPosition()
    local currentBeat = (songPos / 1000)*(bpm/60)
    local speed = getProperty('songSpeed')

    angle = angle + speed

    if dadName == 'madsaw' then
        thethig = true;
    end

    if thethig then
        local sh = math.sin((curStep*2/20)*2)*(300*speed)*0.45;

        setProperty('dad.y', getProperty('dad.y')+(sh-getProperty('dad.y'))/30)

        if curStep > 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000001 then
            setProperty('camHUD.angle', 10 * speed * math.sin(currentBeat * 0.5))
            setProperty('camGame.angle', 10 * speed * math.sin(currentBeat * 0.5))
        end

        for i = 0, getProperty('unspawnNotes.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'angle', angle*speed*4)
            setPropertyFromGroup('opponentStrums', i, 'angle', angle*speed*4)

            setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i..''] + 32 * math.sin((currentBeat + i*7)))
            setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY'..i..''] + 32 * math.sin((currentBeat + i*7)))

            setPropertyFromGroup('playerStrums', i, 'x', _G['defaultPlayerStrumX'..i..''] + 32 * math.sin((currentBeat + i*7)))
            setPropertyFromGroup('opponentStrums', i, 'x', _G['defaultOpponentStrumX'..i..''] + 32 * math.sin((currentBeat + i*7)))
        end
    end
end

function opponentNoteHit()
    if thethig then
        cameraShake('game', 0.01, 0.04)
        cameraShake('hud', 0.01, 0.04)
    end
end