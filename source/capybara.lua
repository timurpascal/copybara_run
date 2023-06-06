import "CoreLibs/animation"

local pd <const> = playdate
local gfx <const> = pd.graphics


class('Capybara').extends(gfx.sprite)

function Capybara:init(x, y)
  local capybaraImage = gfx.image.new("images/capybara_idle")
  local imageTable = gfx.imagetable.new("images/capybara-table-26-21")

  self:moveTo(x, y)
  self:setImage(capybaraImage)
  self:setCollideRect(0, 0, self:getSize())

  self.initialY = y
  self.animationLoop = gfx.animation.loop.new(100, imageTable, true)
  self.jumpAnimation = gfx.animator.new(800, 0, 40, pd.easingFunctions.inOutQuint)
  self.jumpAnimation.reverses = true
  self.moveSpeed = 3
end

function Capybara:jump()
  self.jumpAnimation:reset()
end

function Capybara:updateRunAnimation()
  self:setImage(self.animationLoop:image())
end

function Capybara:updateJumpAnimation()
  local x, y = self:getPosition()
  if self.jumpAnimation then
    self:moveWithCollisions(x, self.initialY - self.jumpAnimation:currentValue())
  elseif self.jumpAnimation:ended() then
    self.moveWithCollisions(x, self.initialY)
  end
end

function Capybara:update()
  Capybara.super.update(self)
  self:updateRunAnimation()
  self:updateJumpAnimation()
  if pd.buttonIsPressed(pd.kButtonUp) then
    self:jump()
  end
end
