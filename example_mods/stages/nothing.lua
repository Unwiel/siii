function onCreate()
    setProperty('camFollow.x', 225);
    setProperty('camFollow.y', 200);
end

function onMoveCamera(focus)
    if focus == 'dad' then
        setProperty('camFollow.x', 225);
        setProperty('camFollow.y', 200);
    end
end