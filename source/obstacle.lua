local pd <const> = playdate
local gfx <const> = pd.graphics


class('Obstacle').extends(gfx.sprite)

function Obstacle:init(x, y, speed, image)
  self:moveTo(x, y)
  self:setImage(image)
  self.speed = speed
end

function Obstacle:update()
  Player.super.update(self)
  self:moveBy(-self.speed, 0)
end
