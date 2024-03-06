local Object = require("libs/classic")

---@alias Position { x: number, y: number }

---@class (exact) Entity: Object, Drawable
---@field super Entity
---@field drawable love.Image
---@field position Position
---@field width number
---@field height number
---@overload fun(position?: Position): Player
local Entity = Object:extend()

---@type fun(self: Entity, image: love.Image, position?: Position)
function Entity:new(image, position)
   self.drawable = image
   self.position = position or { x = 0, y = 0 }
   self.height = image:getHeight()
   self.width = image:getWidth()
end

function Entity:draw()
   love.graphics.draw(self.drawable, self.position.x, self.position.y)
end

return Entity
