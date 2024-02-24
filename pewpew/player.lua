---@meta

local Object = require 'libs/classic'

---@alias MovementDirection 'LEFT' | 'RIGHT' | nil

---@class Player
---@field image love.Image
---@field x number
---@field y number
---@field speed number
---@field width number
---@field movingDirection? MovementDirection
local Player = Object:extend()

---Constructs a new Player instance
function Player:new()
    self.image = love.graphics.newImage("assets/panda.png")
    self.x = 300
    self.y = 20
    self.speed = 250
    self.width = self.image:getWidth()
    self.movingDirection = nil
end

function Player:move(movingDirection)
    self.movingDirection = movingDirection
end

---Updates state of player, called on `love.update`
---@param dt number Delta since the last update
function Player:update(dt)
    -- Movement
    local movingCoeff = 0
    if self.movingDirection == 'LEFT' then
        movingCoeff = -1
    elseif self.movingDirection == 'RIGHT' then
        movingCoeff = 1
    end

    self.x = self.x + self.speed * dt * movingCoeff
end

---Draws the current's player's frame, called on `love.draw`
function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Player
