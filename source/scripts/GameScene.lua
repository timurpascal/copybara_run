local gfx <const> = playdate.graphics
local pd <const> = playdate

TAGS = {
  Player = 1,
  Hazard = 2,
  Pickup = 3
}

Z_INDEXES = {
  Player = 100,
  Hazard = 20,
  Pickup = 50,
  background = -50
}

DEFAULT_SPEED = 5

PLAYER_SIZE = {
  width = 80,
  height = 47,
}
BASE_Y = 200
PD_SCREEN = {
  width = 400,
  height = 240
}

INIT_GROUND = {
  x = 0,
  y = BASE_Y,
}
INIT_PLAYER = {
  x = 20,
  y = BASE_Y - PLAYER_SIZE.height - 10,
}

class('GameScene').extends(gfx.sprite)

function GameScene:init()
  self.achievementSound = pd.sound.sampleplayer.new('images/sounds/achievement.wav')

  self.speed = DEFAULT_SPEED
  self.pointsFromStart = 0
  self.points = 0
  self.timer = 0
  self.timerFromLastEnemy = 0
  self.enemiesCounter = 0
  self.lastEnemy = nil
  self.cloudCounter = 0
  self.lastCloud = nil
  self.dead = false
  self.enemiesDuration = PLAYER_SIZE.width * 5 + self.speed

  -- sprites
  self.player = Player(INIT_PLAYER.x, INIT_PLAYER.y, self)
  self.ground = Ground(INIT_GROUND.x, INIT_GROUND.y, self)
  self.scoreboard = Scoreboard(self)
  self.UI = UI(self)
  self.UI:showStartPanel()


  self.player:add()
  self.inverted = false
  self.scoreboard:add()
  self:add()
end

function GameScene:restart()
  -- self:init()
  -- self.speed = DEFAULT_SPEED
  -- self.pointsFromStart = 0
  -- self.points = 0
  -- self.timer = 0
  -- self.timerFromLastEnemy = 0
  -- self.enemiesCounter = 0
  -- self.lastEnemy = nil
  -- self.cloudCounter = 0
  -- self.lastCloud = nil
  -- self.dead = false
  -- self.player = Player(INIT_PLAYER.x, INIT_PLAYER.y, self)
  -- self.ground = Ground(INIT_GROUND.x, INIT_GROUND.y, self)
  -- self.scoreboard = Scoreboard(self)
end

function GameScene:start()
  self.dead = false
end

function GameScene:defeat()
  self.dead = true
  self.UI:showRestartPanel()
end

function GameScene:createEnemy()
  local enemyType = math.random(2)
  if enemyType == 1 then
    self.lastEnemy = Spike(PD_SCREEN.width, BASE_Y, self)
  elseif enemyType == 2 then
    self.lastEnemy = Pterodactyl(PD_SCREEN.width, BASE_Y, self)
  end
  self.enemiesCounter += 1
end

function GameScene:createCloud()
  self.lastCloud = Cloud(PD_SCREEN.width, BASE_Y - 100, self)
  self.cloudCounter += 1
end

function GameScene:random()
  return math.random() < 0.7
end

function GameScene:spawnEnemy()
  if not self.lastEnemy then
    self:createEnemy()
  elseif self:random() then
    local lastEnemy = self.lastEnemy
    local lastEnemyOffsetX = lastEnemy:getPosition()
    local duration = (PLAYER_SIZE.width * 2) + self.speed
    if lastEnemyOffsetX < PD_SCREEN.width - duration then
      self:createEnemy()
    end
  end
end

function GameScene:spawnCloud()
  if not self.lastCloud then
    self:createCloud()
  elseif self:random() and self.cloudCounter < 3 then
    local lastCloud = self.lastCloud
    local lastCloudOffsetX = lastCloud:getPosition()
    local duration = lastCloud.width / 2
    if lastCloudOffsetX < PD_SCREEN.width - duration then
      self:createCloud()
    end
  end
end

function GameScene:updateScene()
  self.pointsFromStart += 1
  -- прошла секунда
  if self.pointsFromStart == 30 then
    self.timer += 1
    self.pointsFromStart = 0

    self:updateSpeed()
    self:spawnEnemy()
    self:spawnCloud()
    self.scoreboard:updateScore()
  end
end

function GameScene:updateSpeed()
  if self.timer % 20 == 0 then
    self.speed += 1
    pd.display.setInverted(not self.inverted)
    self.inverted = not self.inverted
    self.achievementSound:play()
  end
end

function GameScene:update()
  if self.dead then
    return
  end
  self:updateScene()
end
