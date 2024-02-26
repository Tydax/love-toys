---@meta

local Object = require("libs/classic")
local CollisionSegment = require("collision-segment")
local Movement1D = require("movement-1d")


---@class (exact) Monster
---@field image love.Image
---@field position { x: number, y: number }
---@field movement Movement1D
---@field width number
---@field height number
local Monster = Object:extend()

local INITIAL_SPEED = 250

---Constructs a new Monster instance
---@param x number
---@param y number
function Monster:new(x, y)
   self.image = love.graphics.newImage("assets/snake.png")
   self.position = { x = x, y = y }
   self.movement = Movement1D(INITIAL_SPEED, "x")
   self.width = self.image:getWidth()
   self.height = self.image:getHeight()
end

---Updates state of Monster, called on `love.update`
---@param dt number Delta since the last update
function Monster:update(dt)
   self.movement:update(dt, self.position)
end

function Monster:getCollisionBounds()
   local x = self.position.x
   return CollisionSegment(
      { x = x },
      { x = x + self.width }
   )
end

---Draws the current"s Monster"s frame, called on `love.draw`
function Monster:draw()
   love.graphics.draw(
      self.image,
      self.position.x,
      self.position.y
   )
end

return Monster
