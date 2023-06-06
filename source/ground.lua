local pd <const> = playdate
local gfx <const> = pd.graphics

class('Ground').extends(gfx.sprite)

function Ground:init()
  local ground = gfx.image.new("images/background_image")
  self.startGround = 28

  self:moveTo(self.startGround, 220)
  self:setImage(ground)

  self.moveSpeed = 4
end

function Ground:slideAnimation()
  local x, y = self:getPosition()
  self:moveBy(-self.moveSpeed, 0)
  print(x, y)
  if x == self.moveSpeed then
    self:moveTo(self.startGround, y);
  end
end

function Ground:update()
  Ground.super.update(self)
  self:slideAnimation()
end
