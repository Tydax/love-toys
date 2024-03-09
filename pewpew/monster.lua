local direction = require("direction")
local Entity = require("entity")
local CollisionSegment = require("collision-segment")
local LateralMovement = require("lateral-movement")
local Timer = require("timer")


---@class (exact) Monster: Entity
---@field movement LateralMovement
---@field timer Timer
---@overload fun(position?: Position): Monster
local Monster = Entity:extend()

local INITIAL_SPEED = 50

local function getRandomMovementDelay()
   return love.math.random(500, 3000)
end

---@param self Monster
---@return Timer
local function makeMovementSwitcherTimer(self)
   ---@type TimerCallback
   local function timerCallback(timer)
      self.movement.direction = direction.reverse(
         self.movement.direction
      )
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
   self.movement = LateralMovement(INITIAL_SPEED, direction.getRandom(), "x")
   self.movement.direction = direction.getRandom()
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
      self.movement.direction = direction.reverse(self.movement.direction)
   end
end

return Monster
