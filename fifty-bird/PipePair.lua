--[[
    PipePair Class

    Author: Lacey Gruwell
    gruwell.lacey@gmail.com

    Used to represent a pair of pipes that stick together as they scroll, providig an opening
    for the player to jump through in order to score a point.
]]

PipePair = Class{}

-- size of the gap between pipes    -- moved into init function and randomized
-- local GAP_HEIGHT = 90   -- randomize 90 as part of the homework assignment

function PipePair:init(y)
    -- flag to hold whether this pair has been scored (jumped through)
    self.scored = false
    -- vertical space between the two pipes

    -- initialize pipes pas the end of the screen
    self.x = VIRTUAL_WIDTH + 32

    -- y value is for the topmost pipe; gap is a vertical shift of the second lower pipe
    self.y = y
    
    -- instantiate two pipes that belong to this pair

    local GAP_HEIGHT = math.random(75, 100)
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    -- whether this pipe pair is ready to be removed from the scene
    self.remove = false
end
--[[
function PipePair:getCurrentX()
    return self.x
end

function PipePair:getRandomGapHeight()
    return math.random(GAP_MIN_HEIGHT, GAP_MAX_HEIGHT)
end
]]
function PipePair:update(dt)
    -- remove the pipe from the scene if it's beyond the left edge of the screen,
    -- else move it from right to left
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
