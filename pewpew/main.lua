---@type Player
local player
---@type { left: CollisionSegment, top: CollisionSegment, right: CollisionSegment, bottom: CollisionSegment}
local worldCollisionBounds

function love.load()
   local Player = require("player")
   local CollisionSegment = require("collision-segment")

   player = Player()
   local worldWidth = love.graphics.getWidth()
   local worldHeight = love.graphics.getHeight()
   worldCollisionBounds = {
      left = CollisionSegment({ x = 0 }, { x = 0 }),
      top = CollisionSegment({ x = 0 }, { x = 0 }),
      right = CollisionSegment({ x = worldWidth }, { x = worldWidth }),
      bottom = CollisionSegment({ x = worldHeight }, { x = worldHeight }),
   }
end

function love.update(dt)
   local playerCollisionBounds = player:getCollisionBounds()

   -- Commands
   if
       love.keyboard.isDown("a")
       and not playerCollisionBounds:isCollidingWith(worldCollisionBounds.left)
   then
      player:move("LEFT")
   elseif
       love.keyboard.isDown("d")
       and not playerCollisionBounds:isCollidingWith(worldCollisionBounds.right)
   then
      player:move("RIGHT")
   else
      player:move(nil)
   end

   player:update(dt)
end

function love.draw()
   player:draw()
end
