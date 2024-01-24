local gfx <const> = playdate.graphics


class("Pterodactyl").extends(AnimatedSprite)

function Pterodactyl:init(x, y, gameManager)
  self.gameManager = gameManager

  local pterodactylImageTable = gfx.imagetable.new("images/pterodactyl-table-46-34")
  local random = math.random(3)
  local heigths = { 32, 38, 64 }
  local randomHeight = heigths[random]

  Player.super.init(self, pterodactylImageTable)

  self:addState("idle", 1, 2, { tickStep = 10 })
  self:playAnimation()
  self:setZIndex(Z_INDEXES.Hazard)
  self:setCenter(0, 1)
  self.collisionResponse = playdate.graphics.sprite.kCollisionTypeOverlap
  self:moveTo(x, y - randomHeight)
  self:add()

  self:setTag(TAGS.Hazard)
  self:setCollideRect(0, 0, self:getSize())
end

function Pterodactyl:move()
  local x, y = self:getPosition()
  self:moveWithCollisions(x - self.gameManager.speed, y)

  if x + self.width < 0 then
    self:remove()
    self.gameManager.enemiesCounter -= 1
  end
end

function Pterodactyl:update()
  if self.gameManager.dead then
    return
  end
  self:updateAnimation()
  self:move()
end
