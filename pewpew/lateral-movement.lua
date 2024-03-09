local Object = require("libs/classic")

---@class (exact) LateralMovement: Object
---@field super LateralMovement
---@field direction Direction
---@field coordinate "x" | "y"
---@field speed number
---@overload fun(speed: number, direction: Direction?, coordinate: "x" | "y" | nil): LateralMovement
local LateralMovement = Object:extend()

---@type fun(self: LateralMovement, speed: number, direction: Direction?, coordinate: "x" | "y" | nil)
function LateralMovement:new(speed, direction, coordinate)
   self.coordinate = coordinate or "x"
   self.direction = direction
   self.speed = speed
end

---Updates the specified positionable's state according to the record movement
---@param dt number
---@param positionable Entity
function LateralMovement:update(dt, positionable)
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

return LateralMovement
