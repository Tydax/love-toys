local Object = require("libs/classic")
local Pew = require("pew")
local Timer = require("timer")

---@class (exact) ShootingCapacity: Updatable, Drawable
---@field pews Pew[]
---@field cooldown Timer?
---@overload fun(): ShootingCapacity
local ShootingCapacity = Object:extend()

local COOLDOWN = 250

---@type fun(self: ShootingCapacity)
function ShootingCapacity:new()
   self.pews = {}
end

function ShootingCapacity:shoot(position)
   if self.cooldown then return end

   local pew = Pew(position)
   table.insert(self.pews, pew)

   local cooldownTimer = Timer(COOLDOWN, function()
      self.cooldown = nil
   end)
   self.cooldown = cooldownTimer
end

---@param i integer
function ShootingCapacity:destroyPew(i)
   table.remove(self.pews, i)
end

function ShootingCapacity:update(dt)
   if self.cooldown then
      self.cooldown:update(dt)
   end
   for _, pew in ipairs(self.pews) do
      pew:update(dt)
   end
end

---Draws the current"s player"s frame, called on `love.draw`
function ShootingCapacity:draw()
   for _, pew in ipairs(self.pews) do
      pew:draw()
   end
end

return ShootingCapacity
