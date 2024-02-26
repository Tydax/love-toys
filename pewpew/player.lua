---@meta

local Object = require("libs/classic")
local CollisionSegment = require("collision-segment")
local Movement1D = require("movement-1d")


---@class (exact) Player
---@field image love.Image
---@field position { x: number, y: number }
---@field movement Movement1D
---@field width number
---@field height number
local Player = Object:extend()

local SPEED = 250

---Constructs a new Player instance
---@param x number
---@param y number
function Player:new(x, y)
   self.image = love.graphics.newImage("assets/panda.png")
   self.position = { x = x, y = y }
   self.movement = Movement1D(SPEED, "x")
   self.width = self.image:getWidth()
   self.height = self.image:getHeight()
end

---Updates state of player, called on `love.update`
---@param dt number Delta since the last update
function Player:update(dt)
   self.movement:update(dt, self.position)
end

function Player:getCollisionBounds()
   local x = self.position.x
   return CollisionSegment(
      { x = x },
      { x = x + self.width }
   )
end

---Draws the current"s player"s frame, called on `love.draw`
function Player:draw()
   love.graphics.draw(
      self.image,
      self.position.x,
      self.position.y
   )
end

return Player
