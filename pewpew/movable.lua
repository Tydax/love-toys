local Object = require("libs/classic")


---@class (exact) Movable
---@field direction MovementDirection
---@field coordinate "x" | "y"
---@field speed number
---@overload fun(speed: number, coordinate: "x" | "y"): Movable
local Movable = Object:extend()

---@type fun(self: Movable, speed: number, coordinate: "x" | "y")
function Movable:new(speed, coordinate)
   self.coordinate = coordinate or "x"
   self.direction = nil
   self.speed = speed
end

---Updates the specified positionable's state according to the record movement
---@param dt number
---@param positionable Entity
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
