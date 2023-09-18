--[[
    Bird Class
    Author: Lacey Gruwell
    gruwell.lacey@gmail.com

    The Bird is what we control in the game via clicking or the space bar; whenever we press either,
    the bird will flap and go up a little bit, where it will then be affected by gravity. If the bird hits
    the ground or a pipe, the game is over.
]]

Bird = Class{}

local GRAVITY = 10

function Bird:init()
    self.image = love.graphics.newImage('images/bird.png')  -- load bird image from disk
    self.width = self.image:getWidth()  -- assign its width
    self.height = self.image:getHeight()    -- assign ite height

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)   -- position the bird in the middle of the screen
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2) -- position the bird in the middle of the screen

    self.dy = 0 -- Y velocity; gravity
end

--[[
    AABB collision that expects a pipe, which will have an X and Y and reference
    global pipe width and height values.
]]
function Bird:collides(pipe)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 4) +  (self.width - 8) >= pipe.x and self.x + 4 <= pipe.x + PIPE_WIDTH then
        if (self.y + 4) + (self.height - 8) >= pipe.y and self.y + 4 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt    -- apply gravity to velocity

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = -2    -- add a sudden burst of negative gravity if we hit space
        sounds['jump']:play()
    end

    self.y = self.y + self.dy   -- apply current velocity to Y position
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end
