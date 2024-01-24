local pd <const> = playdate
local gfx <const> = playdate.graphics

class('UI').extends(gfx.sprite)

function UI:init(gameManager)
  self.gameManager = gameManager

  -- gameOverSprites
  self.startupText = nil
  self.defeatText = nil

  self:add()
end

function UI:reset()
  self.score = 0
end

function UI:showRestartPanel()
  self.defeatText = new
  MessageBox(100, 100, 'Press A to restart')
end

function UI:showStartPanel()
  self.startupText = new
  MessageBox(100, 100, 'Press A to start')
end

function UI:update()
  if not self.gameManager.dead then
    return
  else
    if pd.buttonIsPressed(pd.kButtonA) then
      self.gameManager:start()
    end
  end
end
