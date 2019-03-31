local actor = {}

function actor.create( xPos,YPos)
    return{
        x          = xPos,
        y          = YPos,
        rotation   = 0,
        addTexture = actor.addTexture,
        
        --Collider
        addNewBox     = actor.addNewBox,
        addBox        = actor.addBox,
        addNewCircle  = actor.addNewCircle,
        force         = 0,
        position      = actor.position,
        birdController    = actor.birdController,
        ------------
        drawBoxCollider    = actor.drawBoxCollider,
        drawCircleCollider = actor.drawCircleCollider,
        draw               = actor.draw,
        drawBox = actor.drawBox
    }
end

function actor:addTexture(fileName, scale)
    self.texture = love.graphics.newImage(fileName)
    self.scale   = scale
end

function actor:addNewBox(mode)
    self.w       = self.texture:getWidth()
    self.h       = self.texture:getHeight()
    self.body    = love.physics.newBody(world,self.x + (self.w* self.scale)/2, self.y + (self.h* self.scale)/2, mode)
    self.shape   = love.physics.newRectangleShape(self.w* self.scale , self.h* self.scale)
    self.fixture = love.physics.newFixture(self.body, self.shape,1)    
end

function actor:addBox(mode, sizeX,sizeY)
    self.w       = sizeX
    self.h       = sizeY
    self.body    = love.physics.newBody(world,self.x + sizeX/2, self.y + sizeY/2, mode)
    self.body:getAngularDamping(0.1)
    self.shape   = love.physics.newRectangleShape(sizeX , sizeY)
    self.fixture = love.physics.newFixture(self.body, self.shape,1)    
    self.fixture:setRestitution(0) 
    self.fixture:setFriction(1)

end

function actor:addNewCircle(mode,radius)
    self.bounce  = 0 
    self.w       = self.texture:getWidth()
    self.h       = self.texture:getHeight()
    self.body    = love.physics.newBody(world,self.x , self.y, mode)
    self.shape   = love.physics.newCircleShape(radius)
    self.fixture = love.physics.newFixture(self.body, self.shape,1) 
    self.fixture:setRestitution(0.4) 
    self.fixture:setFriction(1)
end

-- function actor:checkBounce()
--     self.body:
-- end

--mode : fill,line
function actor:drawBoxCollider(mode)
    local x,y = self:position()
    love.graphics.rectangle(mode,x-(self.w* self.scale)/2, y-(self.h* self.scale)/2,self.w* self.scale,self.h* self.scale)
end

function actor:drawBox(mode)
    local x,y = self:position()
   -- love.graphics.rectangle(mode,x-self.w/2, y-self.h/2,self.body:getAngle(),self.w,self.h)
    love.graphics.rectangle(mode,x-self.w/2, y-self.h/2,self.w,self.h)

end

function actor:drawCircleCollider(mode)
    local x,y = self:position()
    love.graphics.circle(mode, self.body:getX(), self.body:getY() , self.shape:getRadius())
end


function actor:draw()
    if self.body ~= nil then
        local x,y = self:position()
        --love.graphics.draw(self.texture,x-(self.w* self.scale)/2, y-(self.h* self.scale)/2,self.body:getAngle(),self.scale,self.scale)
        love.graphics.draw(self.texture,x-(self.w* self.scale)/2, y-(self.h* self.scale)/2,0,self.scale,self.scale)
    else
        love.graphics.draw(self.texture,self.x - (self.texture:getWidth() * self.scale)/2,self.y- (self.texture:getHeight()*self.scale)/2,0,self.scale,self.scale)
    end
end

function actor:position()
    return self.body:getX(),self.body:getY()
end

function actor:birdController(xPos,Ypos,decreasePos, forceLimit, addForceX,addForceY)
   
    if love.keyboard.isDown( "left") and force < forceLimit 
    then
        xPos = xPos - decreasePos
        self.body:setX(xPos)    
        self.force = self.force + addForce
    end
    if love.keyboard.isDown( "right") and force > 0  
    then
        
        x = x + decreasePos
        self.body:setX(x)    
        self.force = self.force - addForce
    end
    if love.keyboard.isDown( "up") and force < forceLimit  
    then
    
        y = y + decreasePos
        body:setY(y)    
        force = force + addForce
    end
    
    if love.keyboard.isDown( "down") and force > 0  
    then
    
        y = y + decreasePos
        body:setY(y)    
        force = force - addForce
    end
    
    if love.keyboard.isDown( "space")
    then
        world:setGravity(0,20)
        print(self.force)
        body:applyImpulse(self.force,self.force)
    end


end

return actor

