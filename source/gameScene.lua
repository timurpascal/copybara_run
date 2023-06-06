import "gameOverScene"
import "Capybara"
import "Obstacle"
import "Ground"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
  local crocodileImage = gfx.image.new("images/crocodile")
  local playerInstance = Capybara(100, 200)
  local crocodileInstance = Obstacle(400, 200, 2, crocodileImage)
  local groundInstance = Ground()

  playerInstance:add()
  crocodileInstance:add()
  groundInstance:add()
end

function GameScene:update()
  gfx.sprite.update()
  pd.timer.updateTimers()
end
