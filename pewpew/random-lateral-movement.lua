local direction = require("direction")
local LateralMovement = require("lateral-movement")
local Timer = require("timer")

---@class RandomLateralMovement: LateralMovement
---@field timer Timer
---@overload fun(speed: number, coordinate: "x" | "y"): LateralMovement
local RandomLateralMovement = LateralMovement:extend()


local function getRandomMovementDelay()
   return love.math.random(500, 3000)
end



---@type fun(self: RandomLateralMovement, speed: number, coordinate: "x" | "y" | nil)
function RandomLateralMovement:new(speed, coordinate)
   RandomLateralMovement.super.new(
      self,
      speed,
      direction.getRandom(),
      coordinate
   )
   self.timer = self:makeMovementSwitcherTimer()
end

---@type RandomLateralMovement
---@return Timer
function RandomLateralMovement:makeMovementSwitcherTimer()
   ---@type TimerCallback
   local function timerCallback(timer)
      self.direction = direction.reverse(
         self.direction
      )
      timer.delay = getRandomMovementDelay()
   end
   return Timer(getRandomMovementDelay(), timerCallback, true)
end

---@param dt number
---@param positionable Entity
function RandomLateralMovement:update(dt, positionable)
   self.timer:update(dt)
   RandomLateralMovement.super.update(self, dt, positionable)
end

return RandomLateralMovement
