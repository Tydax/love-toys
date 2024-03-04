local Object = require("libs/classic")
local CollisionSegment = require("collision-segment")
local Movable = require("movable")

---@class (exact) Pew: Drawable, Positionable, Updatable
---@field image love.Image
---@field position Position
---@field movement Movable
---@field width number
---@field height number
local Pew = Object:extend()

local SPEED = 500

---Constructs a new Pew instance
---@param x number
---@param y number
function Pew:new(x, y)
   self.image = love.graphics.newImage("assets/bullet.png")
   self.position = { x = x, y = y }
   self.movement = Movable(SPEED, "y")
   self.movement.direction = "RIGHT"
   self.width = self.image:getWidth()
   self.height = self.image:getHeight()
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

---Draws the current"s pew"s frame, called on `love.draw`
function Pew:draw()
   love.graphics.draw(
      self.image,
      self.position.x,
      self.position.y
   )
end

return Pew
