--[[

	GD50 2023
	Pong Remake

	pong-2
	"The Paddle Update"

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

-- push is a library that will allow us to drraw our game at a virtual
-- resolution, instead of however large our window is; uesd to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move our paddle; multiplied by dt in update
PADDLE_SPEED = 200

--[[
	Runs when the game first starts up, only once; used to start the game
]]
function love.load()
 	love.graphics.setDefaultFilter('nearest', 'nearest')

    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- larger font for drawing the score on the screen
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- set LOVE2D's active font to the smallFont object
    love.graphics.setFont(smallFont)

	-- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
          fullscreen = false,
          resizable = false,
          vsync = true
      })

      -- initialize score variables, used for rendering on the screen and
      -- keeping track of the winner
      player1Score = 0
      player2Score = 0

      -- paddle positions on the Y axis (they can only move up and down)
      player1Y = 30
      player2Y = VIRTUAL_HEIGHT - 50
end

--[[
    Runs every frame, with "dt" passed in, out delta in seconds
    since the last frame, which LOVE2D supplies us.
]]
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1Y = player1Y + -PADDLE_SPEED * dt    -- go up
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player1Y = player1Y + PADDLE_SPEED * dt     -- go down
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2Y = player2Y + -PADDLE_SPEED * dt    -- go up
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player2Y = player2Y  + PADDLE_SPEED * dt    -- go down
    end
end

--[[
  Keyboard handling, called by LOVE2D each frame;
  passes in the key we pressed so we can access.
  ]]
function love.keypressed(key)
  -- keys can be accessed by string name
  if key == 'escape' then
    -- function LOVE gives us to terminate application
    love.event.quit()
  end
end

--[[
	Called after update by LOVE2D, used to draw anything to the screen, 
  updated or otherwise.
]]
function love.draw()
  -- begin rendering at virtual resolution
  push:apply('start')

  -- clear the screen with a specific color; in this case, a color similar to
  -- some versions of the original Pong
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  -- draw welcome text toward the top of the screen
  love.graphics.setFont(smallFont)
  love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

  -- draw score on the left and right center of the screen
  -- need to switch font to draw before actually printing
  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
  love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

  -- 
  -- paddles are simply rectangles we draw on the screen at certain points,
  -- as is the ball
  --

  -- render first paddle (left side) using players' Y variable
  love.graphics.rectangle('fill', 10, player1Y, 5, 20)

  -- render second paddle (right side)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH -10, player2Y - 50, 5, 20)

  -- render ball (center)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH/ 2 - 2, VIRTUAL_HEIGHT / 2 - 2,
  4, 4)

  -- end rendering at virtual resolution
  push:apply('end')
end
