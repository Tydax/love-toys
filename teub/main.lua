io.stdout:setvbuf("no")

local boule_radius = 50
local teub_width   = 75
local teub_height  = 200

local function draw_teub(x, y)
    local boules_y      = y + boule_radius
    local left_boule_x  = x + boule_radius
    local right_boule_x = left_boule_x + boule_radius * 2
    love.graphics.circle("fill", left_boule_x, boules_y, boule_radius)
    love.graphics.circle("fill", right_boule_x, boules_y, boule_radius)

    local boules_middle_x = (right_boule_x + left_boule_x) / 2
    love.graphics.rectangle("fill", boules_middle_x - (teub_width / 2), boules_y, teub_width, teub_height)
end

function love.draw()
    draw_teub(100, 100)
end
