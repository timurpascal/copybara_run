import "CoreLibs/animation"
import "Obstacle"

local pd <const> = playdate
local gfx <const> = pd.graphics


class('Capybara').extends(gfx.sprite)

function Capybara:init(x, y)
  local capybaraImage = gfx.image.new("images/capybara_idle")
  local imageTable = gfx.imagetable.new("images/capybara-table-26-21")

  self:moveTo(x, y)
  self:setImage(capybaraImage)
  self:setCollideRect(0, 0, self:getSize())
  self:setTag(TAGS.Player)

  self.initialY = y
  self.animationLoop = gfx.animation.loop.new(100, imageTable, true)
  self.moveSpeed = 3
end

function Capybara:jump()
  self.jumpAnimation = gfx.animator.new(800, 0, 40, pd.easingFunctions.inOutQuint)
  self.jumpAnimation.reverses = true
end

function Capybara:updateRunAnimation()
  self:setImage(self.animationLoop:image())
end

function Capybara:updateJumpAnimation()
  if self.jumpAnimation then
    local x, y = self:getPosition()
    local _, _, collisions, length = self:moveWithCollisions(x, self.initialY - self.jumpAnimation:currentValue())
    for i = 1, length do
      local collision = collisions[i]
      local collisionObject = collision.other
      if collisionObject:getTag() == TAGS.Obstacle then
        SCENE_MANAGER:switchScene(GameOverScene)
      end
    end
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
