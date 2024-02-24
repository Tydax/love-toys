Player = Object:extend()

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

function Player:update(dt)
    -- Movement
    local movingCoeff = 0
    if self.movingDirection == 'left' then
        movingCoeff = -1
    elseif self.movingDirection == 'right' then
        movingCoeff = 1
    end

    self.x = self.x + self.speed * dt * movingCoeff
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
