world = love.physics.newWorld(0,0,true)

local utils    = require('utils')
local actor    = require('actor')
forceX = 0
forceY = 0
score = 0
function love.load()
    
    love.physics.setMeter(64)

    bird = actor.create(50,400)
    bird:addTexture("bird.png",0.5)
    bird:addNewCircle("dynamic",20)

    pig = actor.create(600,400)
    pig:addTexture("Foreman_Pig.png",0.2)
    pig:addNewCircle("dynamic",20)
   
    -- Sling
    slingFront = actor.create(50,450)
    slingFront:addTexture("slingFront.png",0.5 )
    slingBack  = actor.create(50,450 )
    slingBack:addTexture("slingBack.png",0.5)
    ---------------------------------
   
    ground = actor.create(-100,500)
    ground:addTexture("ground.png",2.5)
    ground:addNewBox("kinematic")

    wallForward = actor.create(800,0)
    wallForward:addBox("kinematic",50,500)

    wallBackward = actor.create(-50,0)
    wallBackward:addBox("kinematic",50,500)



    new_test = actor.create(280,300)
    new_test:addBox("dynamic",200,200)

    boxUnderPig = actor.create(550,410)
    boxUnderPig:addBox("kinematic",100,90)
end

function love.update(dt)
    
    world:update(dt)
    --bird.birdController(bird.x,bird.y,0.5,500,10,10);
    _ , gravityY = world:getGravity()
    if gravityY < 1 
    then

        if love.keyboard.isDown( "left") and forceX < 500 
        then
            bird.x = bird.x - 0.5
            bird.body:setX(bird.x)    
            forceX = forceX + 10
        end
    
        if love.keyboard.isDown( "right") and forceX > 0  
        then
            
            bird.x = bird.x + 0.5
            bird.body:setX(bird.x)    
            forceX = forceX - 10
        end
    
        if love.keyboard.isDown( "up") and forceY > 0 
        then
        
            bird.y = bird.y - 0.5
            bird.body:setY( bird.y)    
            forceY = forceY - 10
        end
    
        if love.keyboard.isDown( "down") and forceY < 500 
        then
        
            bird.y = bird.y + 0.5
            bird.body:setY( bird.y)    
            forceY = forceY + 10
        end
   
    end
    
    if love.keyboard.isDown( "space") and not pressed
    then
        pressed = true
        world:setGravity(0,40)
        --print(self.force)
        bird.body:applyLinearImpulse( forceX /15,-forceY/15)
    end

    if bird.body:isTouching(ground.body) then
    forceX = 0
    forceY = 0
    end

    if  bird.body:isTouching(pig.body) then
        score = score + 1
        pig.body:setActive(false)
        
    end
end

function love.draw()
    slingBack:draw()
    bird:draw()
    slingFront:draw()
    ground:draw()
    new_test:drawBox("line")
   
    if(pig.body:isActive()) then
        pig:draw()
    end
   
    boxUnderPig:drawBox("line")
    love.graphics.print({"Score : " , score}, 30,40,0,2)

end

-- function rotatedRectangle( mode, x, y, w, h, rx, ry, segments, r, ox, oy )
-- 	-- Check to see if you want the rectangle to be rounded or not:
-- 	if not oy and rx then r, ox, oy = rx, ry, segments end
-- 	-- Set defaults for rotation, offset x and y
-- 	r = r or 0
-- 	ox = ox or w / 2
-- 	oy = oy or h / 2
-- 	-- You don't need to indent these; I do for clarity
-- 	love.graphics.push()
-- 		love.graphics.translate( x + ox, y + oy )
-- 		love.graphics.push()
-- 			love.graphics.rotate( -r )
-- 			love.graphics.rectangle( mode, -ox, -oy, w, h, rx, ry, segments )
-- 		love.graphics.pop()
-- 	love.graphics.pop()
-- end

--Momento torcente = r * forza
--r = distanza tra il punto di impatto e fulcro(nel nostro caso il terreno se è appoggiato a terra)