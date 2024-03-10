local Entity = require("entity")
local CollisionSegment = require("collision-segment")
local LateralMovement = require("lateral-movement")

---@class (exact) Pew: Entity
---@field movement LateralMovement
---@overload fun(position?: Position): Pew
local Pew = Entity:extend()

local SPEED = 500

---Constructs a new Pew instance
---@type fun(self: Pew, position?: Position)
function Pew:new(position)
   Pew.super.new(
      self,
      love.graphics.newImage("assets/bullet.png"),
      LateralMovement(SPEED, "RIGHT", "y"),
      position
   )
   self.movement.direction = "RIGHT"
end

---@param axis "HORIZONTAL" | "VERTICAL"
---@return CollisionSegment
function Pew:getCollisionBounds(axis)
   ---@type "x" | "y"
   local coordinate
   ---@type number
   local size
   if axis == "HORIZONTAL" then
      coordinate = "x"
      size = self.width
   else
      coordinate = "y"
      size = self.height
   end

   local x = self.position[coordinate]
   return CollisionSegment(
      { x = x },
      { x = x + size }
   )
end

return Pew
