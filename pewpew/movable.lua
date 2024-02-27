local Object = require("libs/classic")

---@alias Position { x: number, y: number }

---@class (exact) Positionable
---@field position Position

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

---Updates the specified positionable's state according to the record movement
---@param dt number
---@param positionable Positionable
function Movable:update(dt, positionable)
   local movingCoeff = 0
   if self.direction == "LEFT" then
      movingCoeff = -1
   elseif self.direction == "RIGHT" then
      movingCoeff = 1
   end

   local position = positionable.position
   position[self.coordinate] = position[self.coordinate] +
       self.speed * dt * movingCoeff
end

return Movable
