local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Scoreboard').extends(gfx.sprite)

function Scoreboard:init(gameManager)
  self.gameManager = gameManager
  self.score = gameManager.pointsFromStart
  self:updateScore()

  self:setCenter(0, 1)
  self:add()
end

function Scoreboard:reset()
  self.score = 0
end

function Scoreboard:updateScore()
  local scoreText = string.format("*%s*", self.score)
  local textWidth, textHeight = gfx.getTextSize(scoreText)
  local scoreImage = gfx.image.new(textWidth, textHeight)
  gfx.pushContext(scoreImage)
  gfx.drawText(scoreText, 0, 0)
  gfx.popContext()
  self:setImage(scoreImage)
  self:moveTo(PD_SCREEN.width - textWidth - 6, textHeight + 6)
end

function Scoreboard:update()
  if not self.gameManager.dead then
    self.score += self.gameManager.speed
  end
end
