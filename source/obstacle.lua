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
  -- self:moveBy(-self.speed, 0)
  -- local actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.speed, self.y)
  -- if actualX < 0 then
  --   self:moveBy(self.initialX, 0)
  -- end

  -- for i = 1, length do
  --   local collision = collisions[i]
  --   local collisionType = collision.type
  --   local collisionObject = collision.other
  --   if collisionObject:getTag() == TAGS.Player then
  --     SCENE_MANAGER:switchScene(GameOverScene)
  --   end
  -- end
end
