local Entity = require("entity")
local CollisionSegment = require("collision-segment")
local Movable = require("movable")

---@class (exact) Pew: Entity
---@field movement Movable
---@overload fun(position?: Position): Pew
local Pew = Entity:extend()

local SPEED = 500

---Constructs a new Pew instance
---@type fun(self: Pew, position?: Position)
function Pew:new(position)
   Pew.super.new(
      self,
      love.graphics.newImage("assets/bullet.png"),
      position
   )
   self.movement = Movable(SPEED, "y")
   self.movement.direction = "RIGHT"
end

---Updates state of Pew, called on `love.update`
---@param dt number Delta since the last update
function Pew:update(dt)
   self.movement:update(dt, self)
end

function Pew:getCollisionBounds()
   local x = self.position.x
   return CollisionSegment(
      { x = x },
      { x = x + self.width }
   )
end

return Pew
