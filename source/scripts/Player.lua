local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Player').extends(AnimatedSprite)

function Player:init(x, y, gameManager)
  self.gameManager = gameManager

  -- State Machine
  local playerImageTable = gfx.imagetable.new("images/dino-table-160-94")

  Player.super.init(self, playerImageTable)

  -- sounds
  self.deadSound = pd.sound.sampleplayer.new('images/sounds/dead.wav')
  self.jumpSound = pd.sound.sampleplayer.new('images/sounds/jump.wav')

  -- self:addState("wait", 1, 1)
  self:addState("idle", 4, 5, { tickStep = 10 })
  self:addState("jump", 2, 2)
  self:addState("duck", 6, 7, { tickStep = 10 })
  self:addState("dead", 8, 8)
  self:playAnimation()

  -- Sprite Properties
  self:moveTo(x, y)
  self:setZIndex(Z_INDEXES.Player)
  self:setTag(TAGS.Player)
  self:setCenter(0, 0)
  self:setCollideRect(0, 0, 80, 47)


  -- Physics Properties
  self.xVelocity = 0
  self.yVelocity = 0
  self.gravity = 1
  self.maxSpeed = 5
  self.jumpVelocity = -13

  self.jumpBufferAmount = 5
  self.jumpBuffer = 0

  -- Abilities
  self.doubleJumpAbility = true

  -- Double Jump
  self.doubleJumpAvailable = true

  -- Player State
  self.dead = false
end

function Player:collisionResponse(other)
  local tag = other:getTag()

  if tag == TAGS.Hazard or tag == TAGS.Pickup then
    return gfx.sprite.kCollisionTypeOverlap
  end

  return gfx.sprite.kCollisionTypeSlide
end

function Player:update()
  if self.dead then
    return
  end

  self:updateAnimation()
  self:updateJumpBuffer()
  self:handleState()
  self:handleMovementAndCollisions()
end

function Player:updateJumpBuffer()
  self.jumpBuffer -= 1

  if self.jumpBuffer <= 0 then
    self.jumpBuffer = 0
  end

  if pd.buttonJustPressed(pd.kButtonA) then
    self.jumpBuffer = self.jumpBufferAmount
  end
end

function Player:playerJumped()
  return self.jumpBuffer > 0
end

function Player:handleState()
  if self.currentState == "idle" then
    self:applyGravity()
    self:handleGroundInput()
  elseif self.currentState == "run" then
    self:applyGravity()
    self:handleGroundInput()
  elseif self.currentState == "duck" then
    self:applyGravity()
    self:handleGroundInput()
  elseif self.currentState == "jump" then
    if self.touchingGround then
      self:changeToIdleState()
    end

    self:applyGravity()
  end
end

function Player:handleMovementAndCollisions()
  local _, _, collisions, length = self:moveWithCollisions(self.x + self.xVelocity, self.y + self.yVelocity)
  local died = false

  self.touchingGround = false
  self.touchingCeiling = false


  for i = 1, length do
    local collision = collisions[i]
    local collisionType = collision.type
    local collisionObject = collision.other
    local collisionTag = collisionObject:getTag()

    if collisionType == gfx.sprite.kCollisionTypeSlide then
      if collision.normal.y == -1 then
        self.touchingGround = true
        self.doubleJumpAvailable = true
      end
    end

    if (collision.sprite:alphaCollision(collision.other)) then
      if collisionTag == TAGS.Hazard then
        self:die()
      elseif collisionTag == TAGS.Pickup then
        collisionObject:pickUp(self)
      end
    end
  end

  if self.xVelocity < 0 then
    self.globalFlip = 1
  elseif self.xVelocity > 0 then
    self.globalFlip = 0
  end

  if died then
    self:die()
  end
end

function Player:die()
  self.deadSound:play()
  self.xVelocity = 0
  self.yVelocity = 0
  self.dead = true
  self:changeToDead()
  self:setCollisionsEnabled(false)
  self.gameManager:defeat()
end

-- Input Helper Functions

function Player:handleGroundInput()
  if self:playerJumped() then
    self:changeToJumpState()
  elseif pd.buttonIsPressed(pd.kButtonDown) then
    self:changeToDuck()
  else
    self:changeToIdleState()
  end
end

-- State transitions

function Player:changeToIdleState()
  self.xVelocity = 0
  self:changeState("idle")
end

function Player:changeToJumpState()
  self.yVelocity = self.jumpVelocity
  self.jumpBuffer = 0
  self.jumpSound:play()
  self:changeState("jump")
end

function Player:changeToFallState()
  self:changeState("jump")
end

function Player:changeToDuck()
  self:changeState("duck")
end

function Player:changeToDead()
  self:changeState("dead")
end

function Player:applyGravity()
  self.yVelocity += self.gravity

  if self.touchingGround or self.touchingCeiling then
    self.yVelocity = 0
  end
end

function Player:applyDrag(amount)
  if self.xVelocity > 0 then
    self.xVelocity -= amount
  elseif self.xVelocity < 0 then
    self.xVelocity += amount
  end

  if math.abs(self.xVelocity) < self.minimumAirSpeed or self.touchingWall then
    self.xVelocity = 0
  end
end
