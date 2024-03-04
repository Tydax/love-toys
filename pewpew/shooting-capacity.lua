local Object = require("libs/classic")
local Pew = require("pew")
local Timer = require("timer")

---@class (exact) ShootingCapacity: Updatable, Drawable
---@field updatables Updatable[]
---@field drawables Drawable[]
---@field pews Pew[]
---@field isOnCooldown boolean
local ShootingCapacity = Object:extend()

function ShootingCapacity:new()
   self.drawables = {}
   self.updatables = {}
   self.pews = {}
   self.isOnCooldown = false
end

function ShootingCapacity:shoot(position)
   if self.isOnCooldown then return end

   self.isOnCooldown = true
   local pew = Pew(position.x, position.y)
   table.insert(self.pews, pew)
   table.insert(self.drawables, pew)
   table.insert(self.updatables, pew)

   local cooldownTimer = Timer(500, function()
      self.isOnCooldown = false
      self.updatables["COOLDOWN"] = nil
   end)
   cooldownTimer.isGay = true
   self.updatables["COOLDOWN"] = cooldownTimer
end

function ShootingCapacity:update(dt)
   for _, updatable in pairs(self.updatables) do
      updatable:update(dt)
   end
end

---Draws the current"s player"s frame, called on `love.draw`
function ShootingCapacity:draw()
   for _, drawable in ipairs(self.drawables) do
      drawable:draw()
   end
end

return ShootingCapacity
