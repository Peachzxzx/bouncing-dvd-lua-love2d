local scale = 1/5
local speed = 1
local winX,winY = 720,576
local hitcorner = 0
local hitEdge = 0
local r,g,b
local Br,Bg,Bb
local lovePrint = love.graphics.print
local lovePrintf = love.graphics.printf
local function rgbRan()
    r,g,b = love.math.randomNormal(0.2,0.7),love.math.random(0.2,0.7),love.math.randomNormal(0.2,0.7)
    Br,Bg,Bb = 1-r,1-g,1-b
end
local function cornerCount()
    if (x <= 0 or x+w >= winX) and (y <= 0 or y+h >= winY) then
        hitcorner = hitcorner + 1
    end
end
local function edgeCount()
    if x <= 0 or x+w >= winX or y <= 0 or y+h >= winY then
        hitEdge = hitEdge + 1
        rgbRan()
    end
end
local function moveX()
    if s1 and x+w<winX then
        x = x + speed
    else 
        s1 = false
        x = x - speed
        if x <= 0 then
            s1 = true
        end
    end
end
local function moveY()
    if s2 and y+h<winY then
        y = y + speed
    else
        s2 = false
        y = y - speed
        if y <= 0 then
            s2 = true
        end
    end
end
-- initial

function love.load()
    rgbRan()
    love.window.setVSync(0)
    dvd = love.graphics.newImage("dvd2.png")
    x, y = 0,0
    w, h = dvd:getWidth()*scale,dvd:getHeight()*scale
    s1, s2 = true,true
    success = love.window.setMode(winX,winY)
end

function love.update(dt)
    moveX()
    moveY()
    edgeCount()
    cornerCount()
end

function love.draw()
    lovePrint("FPS: "..love.timer.getFPS(), 10, 10)
    lovePrintf([[corner hit counter: ]]..hitcorner, winX-210, 10,200,"right")
    lovePrintf([[edge hit counter: ]]..hitEdge, winX-210, 30,200,"right")
    love.graphics.draw(dvd, x, y,0,scale,scale)
    love.graphics.setColor(r, g, b)
    love.graphics.setBackgroundColor(Br,Bg,Bb)
end