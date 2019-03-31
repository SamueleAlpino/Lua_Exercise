local utils = {}

function utils.createBody(world, x, y, mode,shape, restitution)
    local body    = love.physics.newBody(world, x, y, mode)
    local fixture = love.physics.newFixture(body, shape,1)
    fixture:setRestitution(0.9)
    return body
end

function utils.createDynamicBody(world, x, y, shape, restitution)
     return utile.createBody(world, x, y, "dynamic",shape, restitution)
end

function utils.createStaticBody(world, x, y, shape, restitution)
    return utils.createBody(world, x, y, "static",shape, restitution)
end

function utils.createStaticBox(world,x,y, sizeX,sizeY)
    local shape = love.physics.newRectangleShape(sizeX,sizeY)
    return utils.createStaticBody(world,x,y,shape,0.9)
end

return utils