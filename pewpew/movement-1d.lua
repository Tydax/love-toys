---@meta

local Object = require("libs/classic")

---@alias MovementDirection "LEFT" | "RIGHT" | nil

---@class (exact) Movement1D
---@field direction MovementDirection
---@field coordinate "x" | "y"
---@field speed number
local Movement1D = Object:extend()


function Movement1D:new(speed, coordinate)
   self.coordinate = coordinate or "x"
   self.direction = nil
   self.speed = speed
end

function Movement1D:update(dt, position)
   local movingCoeff = 0
   if self.direction == "LEFT" then
      movingCoeff = -1
   elseif self.direction == "RIGHT" then
      movingCoeff = 1
   end

   position[self.coordinate] = position[self.coordinate] +
       self.speed * dt * movingCoeff
end

return Movement1D
