local pd <const> = playdate
local gfx <const> = playdate.graphics

class('MessageBox').extends(gfx.sprite)

function MessageBox:init(x, y, text)
  self.gameManager = gameManager
  self.text = text
  self.initialX = x
  self.initialY = y
  self.animationTimer = 0
  self.animationDuration = 25
  self.isVisible = true

  self:renderText()
  self:setCenter(0, 1)
  self:add()
end

function MessageBox:blinkAnimation()
  self.score = 0
end

function MessageBox:renderText()
  local textText = string.format("*%s*", self.text)
  local textWidth, textHeight = gfx.getTextSize(textText)
  local textImage = gfx.image.new(textWidth, textHeight)
  gfx.pushContext(textImage)
  gfx.drawText(textText, 0, 0)
  gfx.popContext()
  self:setImage(textImage)
  self:moveTo(self.initialX, self.initialY)
end

function MessageBox:update()
  self.animationTimer += 1
  if self.animationTimer == self.animationDuration then
    self.animationTimer = 0
    self:setVisible(not self.isVisible)
    self.isVisible = not self.isVisible
  end
end
