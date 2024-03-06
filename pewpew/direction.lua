local direction = {}

---@alias Direction "LEFT" | "RIGHT" | nil

function direction.getRandom()
   return ({ "LEFT", "RIGHT" })[love.math.random(1, 2)]
end

---Flips the specified `direction`
---@param direction Direction
---@return Direction
function direction.reverse(direction)
   return direction == "LEFT" and "RIGHT" or "LEFT"
end

return direction
