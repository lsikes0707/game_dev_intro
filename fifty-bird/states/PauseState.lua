--[[
    Pause State

    Author: Lacey Gruwell
    gruwell.lacey@gmail.com

    This state is a window similar to the title screen with a countdown and a text: "Paused"
    displayed across the screen but it also keeps track of the user's score.
]]
--[[
PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.playState = {}
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('space') then
        gStateMachine:change('play', self.playState)
    end
end

function PauseState:enter(playState)
    GAME_PAUSED = true
    self.playState = playState
    sounds['music']:pause()
    sounds['pause']:play()
end

function PauseState:exit()
    GAME_PAUSED = false
    self.playState = {}
    sounds['pause'].play()
    sounds['music'].play()
end

function PauseState:render()
    -- render the Play State elements
    love.graphics.setColor(1, 1, 1, 0.8)
    for k, pair in pairs(self.playState.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Score: ' .. tostring(self.playState.score), 8, 8) -- display score
    self.playState.bird:render()    -- render the flappy bird

    -- draw a translucent modal on top of the Play State elements
    love.graphics.setColor(0, 0, 0, 0.25)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT - GROUND_HEIGHT)

    -- restore color and opacity
    love.graphics.setColor(1, 1, 1, 1)

    -- Pause Menu
    local pauseIconScale = 5
    local pauseIconSize = 16 * pauseIconScale
    local pauseIconY = (VIRTUAL_HEIGHT - GROUND_HEIGHT - pauseIconSize) / 2
    love.graphics.draw(
        getIconTexture(),
        getIconQuads('pause'),
        (VIRTUAL_WIDTH - pauseIconSize) / 2,
        pauseIconY,
        0,
        pauseIconScale,
        pauseIconScale
    )
    love.graphics.setFont(mediumFont)
    love.graphics.printf(
        'Press Enter to resume',
        0,
        PauseIconY + pauseIconSize + mediumFont:getHeight(),
        VIRTUAL_WIDTH,
        'center'
    )
end

]]
