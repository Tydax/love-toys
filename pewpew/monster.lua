local direction = require("direction")
local Entity = require("entity")
local CollisionSegment = require("collision-segment")
local RandomLateralMovement = require("random-lateral-movement")


---@class (exact) Monster: Entity
---@field movement RandomLateralMovement
---@field timer Timer
---@field speedMultiplier integer
---@overload fun(position?: Position): Monster
local Monster = Entity:extend()

local INITIAL_SPEED = 50
local SPEED_INCREMENT = 75

---Constructs a new Monster instance
---@type fun(self: Monster, position?: Position)
function Monster:new(position)
   Monster.super.new(
      self,
      love.graphics.newImage("assets/snake.png"),
      RandomLateralMovement(INITIAL_SPEED, "x"),
      position
   )
   self.speedMultiplier = 0
end

---@param axis "HORIZONTAL" | "VERTICAL"
---@return CollisionSegment
function Monster:getCollisionBounds(axis)
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

function Monster:onColliding(type)
   if type == "WORLD" then
      self.movement.direction = direction.reverse(self.movement.direction)
   end
end

function Monster:onDamage()
   self.speedMultiplier = self.speedMultiplier + 1
   self.movement.speed = INITIAL_SPEED
       + SPEED_INCREMENT * self.speedMultiplier
   print(INITIAL_SPEED, " + ", SPEED_INCREMENT, " ^ ", self.speedMultiplier)
   print(self.movement.speed)
end

return Monster
