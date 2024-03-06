local Object = require("libs/classic")

---@alias TimerCallback fun(self: Timer, dt: number)

---@class (exact) Timer: Updatable An object handling callbacks fired after a given delay
---@field callback TimerCallback Function to call when timer fires
---@field deltaAcc number Time elapsed since the timer creation in ms
---@field delay number Number of milliseconds to wait until firing `callback`
---@field hasFinished boolean `true` if the the timer has finished
---@field isRepeatable boolean `true` if the timer should auto-resets itself and
---every `delay` instead
---@overload  fun(delay: number, callback: TimerCallback, isRepeatable: boolean): Timer
local Timer = Object:extend()

---Constructs a new Timer
---@type fun(self: Timer, delay: number, callback: TimerCallback, isRepeatable: boolean)
function Timer:new(delay, callback, isRepeatable)
   self.callback = callback
   self.deltaAcc = 0
   self.delay = delay
   self.hasFinished = false
   self.isRepeatable = isRepeatable or false
end

---love.update callback
---@param dt number
function Timer:update(dt)
   self.deltaAcc = self.deltaAcc + dt * 1000

   if self.deltaAcc >= self.delay then
      self.hasFinished = true
      self.callback(self, dt)
      if self.isRepeatable then
         self.deltaAcc = 0
      end
   end
end

return Timer
