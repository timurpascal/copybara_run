local pd <const> = playdate
local gfx <const> = pd.graphics

class("Ground").extends(gfx.sprite)

function Ground:init(x, y, gameManager)
  self.gameManager = gameManager
  self.initialX = x
  self.initialY = y
  self.ground = self:createGround()
  self.ground2 = self.ground:copy()
  self.ground2:moveTo(self.ground.width, self.initialY - 18)


  Ground.super.init(self)
  self:add()
end

function Ground:createGround()
  local groundTexture = gfx.image.new("images/ground")
  local groundImpl = gfx.sprite.new()
  groundImpl:setImage(groundTexture)
  groundImpl:setTag(TAGS.Player)
  groundImpl:setCollideRect(0, 18, groundImpl:getSize())
  groundImpl:setCenter(0, 0)
  groundImpl:setZIndex(-100)
  groundImpl:moveTo(self.initialX, self.initialY - 18)
  groundImpl:add()

  return groundImpl
end

function Ground:reset()
  self.ground, self.ground2 = self.ground2, self.ground
  -- self.ground:moveTo(self.initialX, self.initialY - 18)
  self.ground2:moveTo(self.ground.x + self.ground.width, self.initialY - 18)
end

function Ground:moveGround()
  local x, y = self.ground2:getPosition()
  self.ground:moveWithCollisions(self.ground.x - self.gameManager.speed, y)
  self.ground2:moveWithCollisions(x - self.gameManager.speed, y)
  if x < 0 then
    self:reset();
  end
end

function Ground:update()
  Ground.super.update(self)
  if self.gameManager.dead then
    return
  end
  self:moveGround()
end
