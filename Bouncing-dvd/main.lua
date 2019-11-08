local lm,lw,lg=love.math,love.window,love.graphics
local scale=1/5
local speed=1
local winX,winY=720,576
local hitcorner,hitEdge=0,0
local R,G,B
local x,y,w,h
local s1,s0
local dvd
local function rgbRan()
	R,G,B=lm.random(),lm.random(),lm.random()
end
local function cornerCount()
	if(x<=0 or x+w>=winX)and(y<=0 or y+h>=winY)then
		hitcorner=hitcorner+1
	end
end
local function edgeCount()
	if x<=0 or x+w>=winX then
		hitEdge=hitEdge+1
		rgbRan()
	end
	if y<=0 or y+h>=winY then
		hitEdge=hitEdge+1
		rgbRan()
	end
end
local function moveX()
	if s1 and x+w<winX then
		x=x+speed
	else 
		s1=false
		x=x-speed
		if x<=0 then s1=true end
	end
end
local function moveY()
	if s0 and y+h<winY then
		y=y+speed
	else
		s0=false
		y=y-speed
		if y<=0 then s0=true end
	end
end
local function debug()
	lg.printf("FPS: "..love.timer.getFPS(),10,10,200,"left")
	lg.printf(R.." "..G.." "..B,winX-210,50,200,"right")
end
-- initial

function love.load()
	rgbRan() --initializing color
	dvd=lg.newImage("dvd3.png") --initializing image
	x,y=0,0 --initializing top-left corner position of image
	w,h=dvd:getWidth()*scale,dvd:getHeight()*scale --size of image
	s1,s0=true,true --initializing state
	lw.updateMode(winX,winY,{["vsync"]=true}) --initializing window size and vsync
end

function love.update(dt)
	moveX()
	moveY()
	edgeCount()
	cornerCount()
end

function love.draw()
	lg.setColor(R,G,B,1)
	lg.draw(dvd,x,y,0,scale,scale)
	lg.setColor(0.95,0.95,0.95,1)
	lg.printf("corner hit counter: "..hitcorner,winX-210,10,200,"right")
	lg.printf("edge hit counter: "..hitEdge,winX-210,30,200,"right")
	lg.setBackgroundColor(0,0,0)
end