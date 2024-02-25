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
   -- Commands
   if love.keyboard.isDown("a") then
      player:move("LEFT")
   elseif love.keyboard.isDown("d") then
      player:move("RIGHT")
   else
      player:move(nil)
   end

   player:update(dt)

   local playerCollisionBounds = player:getCollisionBounds()
   if playerCollisionBounds:isCollidingWith(worldCollisionBounds.left) then
      player.x = worldCollisionBounds.left.right.x
   elseif playerCollisionBounds:isCollidingWith(worldCollisionBounds.right) then
      player.x = worldCollisionBounds.right.left.x - player.width
   end
end

function love.draw()
   player:draw()
end
