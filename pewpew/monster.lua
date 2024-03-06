local Entity = require("entity")
local CollisionSegment = require("collision-segment")
local Movable = require("movable")
local Timer = require("timer")


---@class (exact) Monster: Entity
---@field movement Movable
---@field timer Timer
---@overload fun(position?: Position): Monster
local Monster = Entity:extend()

local INITIAL_SPEED = 50

local function getRandomDirection()
   return ({ "LEFT", "RIGHT" })[love.math.random(1, 2)]
end

local function reverseDirection(direction)
   return direction == "LEFT" and "RIGHT" or "LEFT"
end

local function getRandomMovementDelay()
   return love.math.random(500, 3000)
end

---@param self Monster
---@return Timer
local function makeMovementSwitcherTimer(self)
   ---@type TimerCallback
   local function timerCallback(timer)
      self.movement.direction = reverseDirection(self.movement.direction)
      timer.delay = getRandomMovementDelay()
   end
   return Timer(getRandomMovementDelay(), timerCallback, true)
end

---Constructs a new Monster instance
---@type fun(self: Monster, position?: Position)
function Monster:new(position)
   Monster.super.new(
      self,
      love.graphics.newImage("assets/snake.png"),
      position
   )
   self.movement = Movable(INITIAL_SPEED, "x")
   self.movement.direction = getRandomDirection()
   self.timer = makeMovementSwitcherTimer(self)
end

---Updates state of Monster, called on `love.update`
---@param dt number Delta since the last update
function Monster:update(dt)
   self.timer:update(dt)
   self.movement:update(dt, self)
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

return Monster
