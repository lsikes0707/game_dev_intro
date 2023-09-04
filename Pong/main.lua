--[[

	GD50 2023
	Pong Remake

	pong-0
	"The Day-0 Update"

	-- Main Program --

	Author: Lacey Gruwell
	gruwell.lacey@gmail.com

	Originally programmed by Atari in 1972. Features two
	paddles, controlled by players, with the goal of getting 
	the ball past your opponent's edge. First to 10 points wins.

	This verison is built to more closely resemble the NES thatn the original Pong machines
	or that Atari 2600 in terms of resolution, though in widescreen  (16:9) so it looks
	nicer on modern systems.
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
	RUNS WHEN THE GAME FIRST STARTS UP, ONLY ONCE; USED TO START THE GAME
]]
function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
end

--[[
	Called after update by LOVE2D, used to draw anything to the screen, updated.
]]

function love.draw()
	love.graphics.printf(
		'Hello Pong!',		-- text to render
		0,			-- starting X (0, since we are going to center it)
		WINDOW_HEIGHT / 2 - 6,	-- starting Y (halfway down the screen)
		WINDOW_WIDTH,		-- number of pixels to center within (the enti..)
		'center')		-- alignment mode, can be 'center', 'left', or 'right'
end
