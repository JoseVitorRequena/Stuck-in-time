require "math"

function screenloader()
    screen = {}
    screen.height, screen.width= 720, 1080
    love.window.setTitle("Survivors")
    love.window.setMode(screen.width, screen.height)
end

function playerloader()
    player = {}
    player.x, player.y = screen.width/2, screen.height/2
end

function love.load()
    enemies = {}
    bullets = {}
    screenloader()
    playerloader()
end

function love.draw()
    love.graphics.setColor(230/255, 111/255, 14/255)
    love.graphics.circle("fill", player.x, player.y, 25)
    
    for k, e in pairs(enemies) do
        love.graphics.setColor(62/255, 5/255, 128/255)
        love.graphics.rectangle("fill", e.x, e.y, 50, 50)
    end
end

function enemyspawn()
    table.insert(enemies, {x = math.random(10, 1050), y = math.random(10, 690)})
end

timer = 1
function love.update(dt)
    Move(dt)
    EnemyMove(dt)
    colitioncheck()
    timer = timer - dt
    if timer <= 0 then
        enemyspawn()
        timer = 2
    end
end

function EnemyMove(dt)
    local v = 250
    for k, e in pairs(enemies) do
        local vx = player.x - e.x-25
        local vy = player.y - e.y-25
        local m = math.sqrt(vx^2 + vy^2)
        vx = vx/m
        vy = vy/m
        e.x = e.x + vx * dt * v
        e.y = e.y + vy * dt * v
        enemies[k] = e
    end
end

function colitioncheck()
    local collision = 26
    for x, e in pairs(enemies) do
        if math.sqrt((e.x - player.x)^2 + (e.y - player.y)^2) < collision then
            love.event.quit()
        end
        if math.sqrt((e.x+50 - player.x)^2 + (e.y - player.y)^2) < collision then
            love.event.quit()
        end
        if math.sqrt((e.x - player.x)^2 + (e.y+50 - player.y)^2) < collision then
            love.event.quit()
        end
        if math.sqrt((e.x+50 - player.x)^2 + (e.y+50 - player.y)^2) < collision then
            love.event.quit()
        end
    end
end

function Move(dt)
    dx, dy = 0, 0
    local v = 400
    if love.keyboard.isDown("d") then
        dx = dx + v
        player.x = player.x + dx * dt
    end
    if love.keyboard.isDown("a") then
        dx = dx - v
        player.x = player.x + dx * dt
    end
    if love.keyboard.isDown("s") then
        dy = dy + v
        player.y = player.y + dy * dt
    end
    if love.keyboard.isDown("w") then
        dy = dy - v
        player.y = player.y + dy * dt
    end
end

function playershoot()
    -- reconhecer direção de olhar
    -- append na lista 
    
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
    if key == "space" then
        playershoot()
    end
end