function OnPiecePlaced(message)
    if not message.WasAllClear then
        return
    end
    -- before animating visibility, set it to 1 so it starts opaque
    SetVisibility(1)
    AnimateVisibility(0, 2)
    -- we don't need to set text here since it's already set
end

SetAlignment("center")
-- here we set color to invisible yellow
-- so we don't have to set visibility separately
SetColor("#ffe44d00")
SetText("ALL CLEAR")

return {
    ["PiecePlaced"] = OnPiecePlaced
}
