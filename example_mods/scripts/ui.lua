local comboOffsetW = {0, 0, 0, 0} -- defining it with some premade stuff just incase

function onCreatePost()
	comboOffsetW = getPropertyFromClass('ClientPrefs', 'comboOffset') -- getting the array
    makeLuaText('composerTxt', songName, 500, -500, 280)

    setTextAlignment('composerTxt', 'center')

    setTextSize('composerTxt', 36)
    setTextFont('composerTxt', 'DK Black Bamboo.ttf')
    addLuaText('composerTxt')
end

function onSongStart()
    doTweenX('goddamn2', 'composerTxt', -90, 0.77, 'cubeout')
end

local onetime = false
function onUpdatePost()
    if onetime == false then
    setProperty('botplayTxt.text', 'PUSSY')
    setTextFont("scoreTxt", "DK Black Bamboo.ttf")
    setTextFont("botplayTxt", "DK Black Bamboo.ttf")
    setTextFont("timeTxt", "DK Black Bamboo.ttf")
    onetime = true
    end

    if ratingName == '?' then
        setRatingName('?') --When there are no notes
    end
    if ratingName == 'You Suck!' then
        setRatingName('BANNED') --From 0% to 19% of accuracy
    end
    if ratingName == 'Shit' then
        setRatingName('Bruh') --From 20% to 39% of accuracy
    end
    if ratingName == 'Bad' then
        setRatingName('Ok') --From 40% to 49% of accuracy
    end
    if ratingName == 'Bruh' then
        setRatingName('Eh') --From 50% to 59% of accuracy
    end
    if ratingName == 'Meh' then
        setRatingName('Meh') --From 60% to 68% of accuracy
    end
    if ratingName == 'Nice' then
        setRatingName('Good') --69% of accuracy :bruh:
    end
    if ratingName == 'Good' then
        setRatingName('Cool') --From 70% to 79% of accuracy
    end
    if ratingName == 'Great' then
        setRatingName('Great') --From 80% to 89% of accuracy
    end
    if ratingName == 'Sick!' then
        setRatingName('Sick!') --From 90% to 99% of accuracy
    end
    if ratingName == 'Perfect!!' then
        setRatingName('Perfect!!') --100% of accuracy
    end
    
    if curStep == 20 then
        doTweenX('goddamn5', 'composerTxt', -425, 0.632, 'cubein')
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)

	if not isSustainNote and getProperty('combo') > 10 then

		makeLuaSprite('combo' .. getProperty('combo'), 'combo', 485 + comboOffsetW[3], 360 - comboOffsetW[4])
		setObjectCamera('combo' .. getProperty('combo'), 'hud')
		scaleObject('combo' .. getProperty('combo'), 0.55, 0.55)
		addLuaSprite('combo' .. getProperty('combo'), true)
		setProperty('combo' .. getProperty('combo') .. '.velocity.y', 600)
		setProperty('combo' .. getProperty('combo') .. '.velocity.y', -150)
		doTweenAlpha('tweenCombo3' .. getProperty('combo'), 'combo' .. getProperty('combo'), 0, 0.35, 'quartIn')
	end
end