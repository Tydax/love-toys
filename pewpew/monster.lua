---@meta

local Object = require("libs/classic")
local CollisionSegment = require("collision-segment")
local Movable = require("pewpew.movable")
local Timer = require("timer")


---@class (exact) Monster
---@field image love.Image
---@field position { x: number, y: number }
---@field movement Movable
---@field width number
---@field height number
---@field timer Timer
local Monster = Object:extend()

local INITIAL_SPEED = 50

local function getRandomDirection()
   return ({ "LEFT", "RIGHT" })[love.math.random(1, 2)]
end

local function reverseDirection(direction)
   return direction == "LEFT" and "RIGHT" or "LEFT"
end

---Constructs a new Monster instance
---@param x number
---@param y number
function Monster:new(x, y)
   self.image = love.graphics.newImage("assets/snake.png")
   self.position = { x = x, y = y }
   self.movement = Movable(INITIAL_SPEED, "x")
   self.movement.direction = getRandomDirection()
   self.width = self.image:getWidth()
   self.height = self.image:getHeight()
   self.timer = self:makeMovementSwitcherTimer()
end

function Monster:makeMovementSwitcherTimer()
   local timerCallback = function()
      self.movement.direction = reverseDirection(self.movement.direction)
      self.timer = self:makeMovementSwitcherTimer()
   end
   return Timer(love.math.random(500, 3000), timerCallback, false)
end

---Updates state of Monster, called on `love.update`
---@param dt number Delta since the last update
function Monster:update(dt)
   self.timer:update(dt)
   self.movement:update(dt, self.position)
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
      self.movement.direction = reverseDirection(self.movement.direction)
   end
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
