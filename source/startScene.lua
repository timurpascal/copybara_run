import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('StartScene').extends(gfx.sprite)

function StartScene:init()
  local text = "Press A button to start"
  local startImage = gfx.image.new(gfx.getTextSize(text))
  gfx.pushContext(startImage)
  gfx.drawText(text, 0, 0)
  gfx.popContext()

  local startSprite = gfx.sprite.new(startImage)
  startSprite:moveTo(200, 120)
  startSprite:add()

  self:add()
end

function StartScene:update()
  if pd.buttonIsPressed(pd.kButtonA) then
    SCENE_MANAGER:switchScene(GameScene)
  end
end
