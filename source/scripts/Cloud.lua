local gfx <const> = playdate.graphics

class("Cloud").extends(gfx.sprite)

function Cloud:init(x, y, gameManager)
  self.gameManager = gameManager

  self:setZIndex(Z_INDEXES.background)
  local cloudImage = gfx.image.new("images/cloud")
  self:setImage(cloudImage, 0)
  self:setCenter(0, 1)
  self:moveTo(x, y - math.random(50))
  self:add()
end

function Cloud:move()
  local x, y = self:getPosition()
  self:moveBy(-self.gameManager.speed / 2, 0)

  if x + self.width < 0 then
    self:remove()
    self.gameManager.cloudCounter -= 1
  end
end

function Cloud:update()
  if self.gameManager.dead then
    return
  end
  self:move()
end
