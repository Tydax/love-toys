---@type Player
local player

function love.load()
    Object = require 'libs/classic'
    require 'player'

    player = Player()
end

function love.update(dt)
    -- Commands
    if love.keyboard.isDown('a') then
        player:move('left')
    elseif love.keyboard.isDown('d') then
        player:move('right')
    else
        player:move(nil)
    end

    player:update(dt)
end

function love.draw()
    player:draw()
end
