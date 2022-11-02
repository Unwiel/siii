function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'HAMMER Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'HAMMERNOTE_assets'); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'HAMMER Note' then
		characterPlayAnim('bf', 'hurt', true)
		setProperty('boyfriend.specialAnim', true);
		playSound('SawShooting')
		runTimer('killhim', 0.2, 1)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'killhim' then
		setProperty('health', 0)
    end
end