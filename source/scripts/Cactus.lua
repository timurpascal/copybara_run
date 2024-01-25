local gfx <const> = playdate.graphics

local cactusNames = {
  'cactus-big-1',
  'cactus-big-2',
  'cactus-big-3',
  'cactus-small-1',
  'cactus-small-2',
  'cactus-small-3',
}

class("Cactus").extends(gfx.sprite)

function Cactus:init(x, y, gameManager)
  self.gameManager = gameManager

  self:setZIndex(Z_INDEXES.Hazard)
  local randomCactusName = cactusNames[math.random(#cactusNames)]
  local cactusImage = gfx.image.new(string.format("images/cactus/%s", randomCactusName))
  self:setImage(cactusImage, 0, 0.5)
  self:setCenter(0, 1)
  self.collisionResponse = playdate.graphics.sprite.kCollisionTypeOverlap
  self:moveTo(x, y)
  self:add()

  self:setTag(TAGS.Hazard)
  self:setCollideRect(0, 0, self:getSize())
end

function Cactus:moveEnemy()
  local x, y = self:getPosition()
  local _, _, collisions, length = self:moveWithCollisions(x - self.gameManager.speed, y)

  if x + self.width < 0 then
    self:remove()
    self.gameManager.enemiesCounter -= 1
  end
end

function Cactus:update()
  if self.gameManager.dead then
    return
  end
  self:moveEnemy()
end
