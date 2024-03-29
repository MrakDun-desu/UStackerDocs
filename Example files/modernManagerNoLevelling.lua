function HandlePiecePlaced(message)
    local scoreAddition = 0
    if message.WasSpin then
        scoreAddition = scoreAddition + (message.LinesCleared + 1) * 400
    elseif message.WasSpinMini then
        if message.LinesCleared == 0 then
            scoreAddition = scoreAddition + 100
        elseif message.LinesCleared == 1 then
            scoreAddition = scoreAddition + 200
        elseif message.LinesCleared == 2 then
            scoreAddition = scoreAddition + 400
        elseif message.LinesCleared > 2 then
            scoreAddition = scoreAddition + message.LinesCleared * 300
        end
    else
        if message.LinesCleared == 1 then
            scoreAddition = scoreAddition + 100
        elseif message.LinesCleared == 2 then
            scoreAddition = scoreAddition + 300
        elseif message.LinesCleared == 3 then
            scoreAddition = scoreAddition + 500
        elseif message.LinesCleared > 3 then
            scoreAddition = scoreAddition + message.LinesCleared * 200
        end
    end

    scoreAddition = scoreAddition + message.CurrentCombo * 50

    if message.WasAllClear then
        scoreAddition = scoreAddition + 3000
    end

    if scoreAddition == 0 then
        return
    end

    if message.CurrentBackToBack >= 1 and message.LinesCleared > 0 then
        scoreAddition = scoreAddition * 1.5
    end

    AddScore(scoreAddition)
end

function HandlePieceMoved(message)
    local scoreAddition = 0
    if message.WasHardDrop then
        scoreAddition = scoreAddition + (message.Y * -2)
    elseif message.WasSoftDrop then
        scoreAddition = scoreAddition + ( -message.Y)
    end

    if scoreAddition == 0 then
        return
    end

    AddScore(scoreAddition)
end

function Reset(message)
    if message.NewState:ToString() == "Initializing" then
        SetLevel("")
        SetLevelUpCondition(0, 0, "None")
    end
end

return {
    ["PiecePlaced"] = HandlePiecePlaced,
    ["PieceMoved"] = HandlePieceMoved,
    ["GameStateChanged"] = Reset
}
