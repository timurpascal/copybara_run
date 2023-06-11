import "gameOverScene"
import "Capybara"
import "Obstacle"
import "Ground"

local pd <const> = playdate
local gfx <const> = playdate.graphics

TAGS = {
  Obstacle = 1,
  Ground = 2,
  Player = 3
}

class('GameScene').extends(gfx.sprite)

function GameScene:init()
  local crocodileImage = gfx.image.new("images/crocodile")
  local playerInstance = Capybara(100, 200)
  local crocodileInstance = Obstacle(400, 200, 2, crocodileImage)
  local groundInstance = Ground()

  playerInstance:add()
  crocodileInstance:add()
  groundInstance:add()

  self:add()
end

function GameScene:update()
  if pd.buttonJustPressed(pd.kButtonA) then
    SCENE_MANAGER:switchScene(GameOverScene)
  end
end
