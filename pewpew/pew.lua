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

function Pew:getCollisionBounds()
   local x = self.position.x
   return CollisionSegment(
      { x = x },
      { x = x + self.width }
   )
end

return Pew
