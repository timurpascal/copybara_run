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

class('GameScene').extends(gfx.sprite)

function GameScene:init()
  -- local crocodileImage = gfx.image.new("images/crocodile")
  local playerInstance = Capybara(100, 200)
  -- local crocodileInstance = Obstacle(400, 200, 2, crocodileImage)
  local groundInstance = Ground()

  self.obstacleInstance = nil

  playerInstance:add()
  -- crocodileInstance:add()
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
    local actualX, actualY, collisions, length = obstacle:moveWithCollisions(obstacle.x - obstacle.speed, obstacle.y)
    -- obstacle:moveBy(-obstacle.speed, 0)
    for i = 1, length do
      local collision = collisions[i]
      local collisionObject = collision.other
      if collisionObject:getTag() == TAGS.Player then
        SCENE_MANAGER:switchScene(GameOverScene)
      end
    end

    local width = obstacle:getSize()
    if actualX + width < 0 then
      obstacle:remove()
      self.obstacleInstance = nil
    end
  end
end

function GameScene:update()
  self:spawnObstacle()
  self:moveObsticle()
end
