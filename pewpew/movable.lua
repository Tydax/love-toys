local Object = require("libs/classic")

---@alias MovementDirection "LEFT" | "RIGHT" | nil

---@class (exact) Movable
---@field direction MovementDirection
---@field coordinate "x" | "y"
---@field speed number
local Movable = Object:extend()


function Movable:new(speed, coordinate)
   self.coordinate = coordinate or "x"
   self.direction = nil
   self.speed = speed
end

function Movable:update(dt, position)
   local movingCoeff = 0
   if self.direction == "LEFT" then
      movingCoeff = -1
   elseif self.direction == "RIGHT" then
      movingCoeff = 1
   end

   position[self.coordinate] = position[self.coordinate] +
       self.speed * dt * movingCoeff
end

return Movable
