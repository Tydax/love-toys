---@type Player
local player
---@type Monster
local monster

---@type { left: CollisionSegment, top: CollisionSegment, right: CollisionSegment, bottom: CollisionSegment}
local worldCollisionBounds

function love.load()
   local Player = require("player")
   local Monster = require("monster")
   local CollisionSegment = require("collision-segment")

   local worldWidth = love.graphics.getWidth()
   local worldHeight = love.graphics.getHeight()
   local worldWidthMiddleX = worldWidth / 2

   player = Player(0, 5)
   -- Set to middle
   player.position.x = worldWidthMiddleX - player.width / 2

   monster = Monster(0, 0)
   -- Set to middle
   monster.position.x = worldWidthMiddleX - monster.width / 2
   monster.position.y = worldHeight - monster.height - 5

   worldCollisionBounds = {
      left = CollisionSegment({ x = 0 }, { x = 0 }),
      top = CollisionSegment({ x = 0 }, { x = 0 }),
      right = CollisionSegment({ x = worldWidth }, { x = worldWidth }),
      bottom = CollisionSegment({ x = worldHeight }, { x = worldHeight }),
   }
end

local function updateObjectPositionIfCollidingWithWorld(object)
   local collisionBounds = object:getCollisionBounds()
   if collisionBounds:isCollidingWith(worldCollisionBounds.left) then
      object.position.x = worldCollisionBounds.left.right.x
   elseif collisionBounds:isCollidingWith(worldCollisionBounds.right) then
      object.position.x = worldCollisionBounds.right.left.x - object.width
   end
end

function love.update(dt)
   -- Commands
   if love.keyboard.isDown("a") then
      player.movement.direction = "LEFT"
   elseif love.keyboard.isDown("d") then
      player.movement.direction = "RIGHT"
   else
      player.movement.direction = nil
   end

   player:update(dt)
   monster:update(dt)

   updateObjectPositionIfCollidingWithWorld(player)
end

function love.draw()
   player:draw()
   monster:draw()
end
