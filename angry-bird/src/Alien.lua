--[[
    GD50
    Angry Birds Remake

    Author:
    email
]]

Alien = Class{}

function Alien:init(world, type, x, y, userData)
    self.world = world
    self.type = type or 'square'

    self.body = love.physics.newBody(self.world, 
        x or math.random(VIRTUAL_WIDTH), y or math.random(VIRTUAL_HEIGHT - 35),
        'dynamic')

    -- different shape and sprite based on type passed in
    if self.type == 'square' then
        self.shape = love.physics.newRectangleShape(35, 35)
        self.sprite = math.random(5)
    else
        self.shape = love.physics.newCircleShape(17.5)
        self.sprite = 9
    end

    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setUserData(userData)

    -- used to keep track of despawning the Alien and flinging it
    self.launched = false

end

function Alien:render()
    love.graphics.draw(gTextures['aliens'], gFrames['aliens'][self.sprite],
        math.floor(self.body:getX()), math.floor(self.body:getY()), self.body:getAngle(),
        1, 1, 17.5, 17.5)
end

-- handles alien splitting, creates two child aliens and sets their velocity
function Alien:split()
    gSounds['split']:play()

    -- disable future spliting
    self.canSplit = false

    -- get component velocities of parent alien
    local vx, vy = self.body:getLinearVelocity()

    -- instantiate 1st alien (heading clockwise from parent)
    self.children[1] = Alien(self.world, self.type, self.body:getX(), self.body:getY(), 'Player')

    -- swaping x & y velocities creates perpendicular motion
    self.children[1].body:setLinearVelocity(vy/2, -vx/2)
    self.children[1].sprite = 10

    -- instantiate 2nd alien (heading anti-clockwise from parent)
    self.children[2] = Alien(self.world, self.type, self.body:getX(), self.body:getY(), 'Player')

    -- as above, but negate y component for perpendicular motion
    -- in opposite direction
    self.children[2].body:setLinearVelocity(-vy/2, vx/2)
    self.children[2].sprite = 7

    -- Aliens init w/ in group -1 to avoid collisions on spawn
    -- Reset this to 0 once enough time has passed for them to seperate

    Timer.after(0.2, function()
        self.children[1].fixture:setGroupIndex(0)
        self.children[2].fixture:setGroupIndex(0)
    end)

    return
end
