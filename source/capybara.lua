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
  self.animationLoop = gfx.animation.loop.new(100, imageTable, true)
  self.moveSpeed = 3
end

function Capybara:jump()
  local timer = pd.timer.new(0, 10)
end

function Capybara:updateRunAnimation()
  print(self.animationLoop.frame)
  self:setImage(self.animationLoop:image())
end

function Capybara:update()
  Capybara.super.update(self)
  self:updateRunAnimation()
  -- if pd.buttonIsPressed(pd.kButtonUp) then
  --   self:jump()
  -- end
end
