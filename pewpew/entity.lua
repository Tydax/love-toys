local Object = require("libs/classic")
local Movement = require("lateral-movement")

---@alias Position { x: number, y: number }

---@class (exact) Entity: Object, Drawable, Updatable
---@field super Entity
---@field drawable love.Image
---@field movement LateralMovement
---@field position Position
---@field width number
---@field height number
---@overload fun(image: love.Image, movement: LateralMovement, position?: Position): Player
local Entity = Object:extend()

---@type fun(self: Entity, image: love.Image, movement: LateralMovement, position?: Position)
function Entity:new(image, movement, position)
   self.drawable = image
   self.position = position or { x = 0, y = 0 }
   self.height = image:getHeight()
   self.width = image:getWidth()
   self.movement = movement
end

function Entity:update(dt)
   self.movement:update(dt, self)
end

function Entity:draw()
   love.graphics.draw(self.drawable, self.position.x, self.position.y)
end

return Entity
