import "gameOverScene"
import "Capybara"
import "Obstacle"
import "Ground"

local pd <const> = playdate
local gfx <const> = playdate.graphics

TAGS = {
  Obstacle = 1,
  Ground = 2,
  Player = 3
}

OBSTACLE_NAMES = {
  crocodile = 1,
  cactus = 2,
  rock = 3
}

OBSTACLE_BASE_COORDINATES = {
  x = 500,
  y = 200
}

local labelSprite = nil
local labelImage = nil

class('GameScene').extends(gfx.sprite)

function GameScene:init()
  local playerInstance = Capybara(100, 200)
  local groundInstance = Ground()

  self.obstacleInstance = nil
  self.score = 0
  self.scoreTimer = pd.timer.new(1, 1)
  self.scoreTimer.repeats = true
  self.scoreTimer.updateCallback = function(timer)
    if timer.value == 0 then
      self.score += 1
    end
  end

  labelSprite = gfx.sprite.new()
  labelImage = gfx.image.new(200, 20)
  gfx.pushContext(labelImage)
    gfx.drawText("Score: " .. self.score, 0, 0)
  gfx.popContext()
  labelSprite:setImage(labelImage)
  labelSprite:add()
  labelSprite:setCenter(0, 0)
  labelSprite:moveTo(10, 10)

  playerInstance:add()
  groundInstance:add()

  self:add()
end

function GameScene:spawnObstacle()
  if not self.obstacleInstance then
    local rundomObsticleNumber = math.random(1, 3)
    if rundomObsticleNumber == OBSTACLE_NAMES.crocodile then
      local crocodileImage = gfx.image.new("images/crocodile")
      self.obstacleInstance = Obstacle(OBSTACLE_BASE_COORDINATES.x, OBSTACLE_BASE_COORDINATES.y, 4, crocodileImage)
    end
    if rundomObsticleNumber == OBSTACLE_NAMES.cactus then
      local cactusImage = gfx.image.new("images/cactus")
      self.obstacleInstance = Obstacle(OBSTACLE_BASE_COORDINATES.x, OBSTACLE_BASE_COORDINATES.y, 4, cactusImage)
    end
    if rundomObsticleNumber == OBSTACLE_NAMES.rock then
      local rockImage = gfx.image.new("images/rock")
      self.obstacleInstance = Obstacle(OBSTACLE_BASE_COORDINATES.x, OBSTACLE_BASE_COORDINATES.y, 4, rockImage)
    end

    self.obstacleInstance:add()
  end
end

function GameScene:moveObsticle()
  if self.obstacleInstance then
    local obstacle = self.obstacleInstance
    local actualX, _, collisions, length = obstacle:moveWithCollisions(obstacle.x - obstacle.speed, obstacle.y)
    for i = 1, length do
      local collision = collisions[i]
      local collisionObject = collision.other
      if collisionObject:getTag() == TAGS.Player then
        SCENE_MANAGER:switchScene(GameOverScene, "Score: " .. self.score)
      end
    end

    local width = obstacle:getSize()
    if actualX + width < 0 then
      obstacle:remove()
      self.obstacleInstance = nil
    end
  end
end

function GameScene:updateScore()
  labelImage:clear(gfx.kColorWhite)
  gfx.pushContext(labelImage)
    gfx.drawText("Score: " .. self.score, 0, 0)
  gfx.popContext()
end

function GameScene:update()
  self:spawnObstacle()
  self:moveObsticle()
  self:updateScore()
end
