local direction = require("direction")
local Entity = require("entity")
local CollisionSegment = require("collision-segment")
local RandomLateralMovement = require("random-lateral-movement")


---@class (exact) Monster: Entity
---@field movement RandomLateralMovement
---@field timer Timer
---@overload fun(position?: Position): Monster
local Monster = Entity:extend()

local INITIAL_SPEED = 50

---Constructs a new Monster instance
---@type fun(self: Monster, position?: Position)
function Monster:new(position)
   Monster.super.new(
      self,
      love.graphics.newImage("assets/snake.png"),
      RandomLateralMovement(INITIAL_SPEED, "x"),
      position
   )
end

function Monster:getCollisionBounds()
   local x = self.position.x
   return CollisionSegment(
      { x = x },
      { x = x + self.width }
   )
end

function Monster:onColliding(type)
   if type == "WORLD" then
      self.movement.direction = direction.reverse(self.movement.direction)
   end
end

return Monster
