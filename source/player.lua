local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y, image)
  self:moveTo(x, y)
  self:setImage(image)
  self.moveSpeed = 3
end

function Player:update()
  Player.super.update(self)
  if pd.buttonIsPressed(pd.kButtonLeft) then
    self:setImageFlip(0)
    self:moveBy(-self.moveSpeed, 0)
  elseif pd.buttonIsPressed(pd.kButtonRight) then
    self:setImageFlip(1)
    self:moveBy(self.moveSpeed, 0)
  end
end
