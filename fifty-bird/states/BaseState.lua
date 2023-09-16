--[[
    GD50 2023
    Flappy Bird Remake

    -- BaseState Class --

    Author: Lacey Gruwell
    gruwell.lacey@gmail.com

    Used as the base class for all of our states, so we don't have to
    define empty methods in each of them. StateeMachine requires each
    State have a set of four "interface" methods that it can reliable call,
    so by inheriting form this base state, our State classes will all have
    at leas empty version of these methods even if we don't define them
    ourselves in the actual classes.
]]

BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end
