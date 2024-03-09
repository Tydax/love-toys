local CollisionSegment = require("collision-segment")
local LateralMovement = require("lateral-movement")
local ShootingCapacity = require("shooting-capacity")
local Entity = require("entity")

---@class (exact) Player: Entity
---@field shootingCapacity ShootingCapacity
---@overload fun(position?: Position): Player
local Player = Entity:extend()

local SPEED = 250

---Constructs a new Player instance
---@type fun(self: Player, position?: Position)
function Player:new(position)
   Player.super.new(
      self,
      love.graphics.newImage("assets/panda.png"),
      LateralMovement(SPEED, nil, "x"),
      position
   )
   self.shootingCapacity = ShootingCapacity()
end

---Updates state of player, called on `love.update`
---@param dt number Delta since the last update
function Player:update(dt)
   Player.super.update(self, dt)
   self.shootingCapacity:update(dt)
end

function Player:getCollisionBounds()
   local x = self.position.x
   return CollisionSegment(
      { x = x },
      { x = x + self.width }
   )
end

function Player:shoot()
   local shootingPosition = {
      x = self.position.x + self.width / 2,
      y = self.position.y + self.height
   }
   self.shootingCapacity:shoot(shootingPosition)
end

---Draws the current"s player"s frame, called on `love.draw`
function Player:draw()
   Player.super.draw(self)
   self.shootingCapacity:draw()
end

return Player
