import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init(text)
  local gameOverText = "Game Over"
  local gameOverImage = gfx.image.new(gfx.getTextSize(gameOverText))
  gfx.pushContext(gameOverImage)
  gfx.drawText(gameOverText, 0, 0)
  gfx.popContext()
  local gameOverSprite = gfx.sprite.new(gameOverImage)
  gameOverSprite:moveTo(200, 50)
  gameOverSprite:add()

  local scoreText = gfx.image.new(gfx.getTextSize(text))
  gfx.pushContext(scoreText)
  gfx.drawText(text, 0, 0)
  gfx.popContext()
  local scoreSprite = gfx.sprite.new(scoreText)
  scoreSprite:moveTo(200, 100)
  scoreSprite:add()

  local discribeText = "Press *A* to restart"
  local discribeImage = gfx.image.new(gfx.getTextSize(discribeText))
  gfx.pushContext(discribeImage)
  gfx.drawText(discribeText, 0, 0)
  gfx.popContext()
  local scoreSprite = gfx.sprite.new(discribeImage)
  scoreSprite:moveTo(200, 150)
  scoreSprite:add()

  self:add()
end

function GameOverScene:update()
  if pd.buttonJustPressed(pd.kButtonA) then
    SCENE_MANAGER:switchScene(GameScene)
  end
end
