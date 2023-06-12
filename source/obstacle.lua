local pd <const> = playdate
local gfx <const> = pd.graphics


class('Obstacle').extends(gfx.sprite)

function Obstacle:init(x, y, speed, image)
  self:moveTo(x, y)
  self:setImage(image)
  self:setCollideRect(0, 0, self:getSize())
  self:setTag(TAGS.Obstacle)
  self.speed = speed
  self.initialX = x
end

function Obstacle:update()
  Obstacle.super.update(self)
end
