local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start  timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		startDialogue('dialogue');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

local fuckyou = false

function onUpdatePost(elapsed)
    local songPos = getSongPosition()
    local currentBeat = (songPos / 1000)*(bpm/60)

    if fuckyou then
        for i = 0, getProperty('unspawnNotes.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i..''] + 32 * math.sin((currentBeat + i*7)))
            setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY'..i..''] + 32 * math.sin((currentBeat + i*7)))
        end
    else
        for i = 0, getProperty('unspawnNotes.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i..''])
            setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY'..i..''])
        end        
    end
end

function onStepHit()
    if curStep == 669 then
        fuckyou = true
    end
    if curStep == 796 then
        fuckyou = false
    end
end