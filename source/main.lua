-- CoreLibs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- Libraries
import "scripts/libraries/AnimatedSprite"

-- Game
import "scripts/GameScene"
import "scripts/Player"
import "scripts/Spike"
import "scripts/Pterodactyl"
import "scripts/Spikeball"
import "scripts/Ability"
import "scripts/Ground"
import "scripts/Scoreboard"
import "scripts/Cloud"
import "scripts/UI"
import "scripts/MessageBox"

GameScene()

local pd <const> = playdate
local gfx <const> = playdate.graphics

function pd.update()
  gfx.sprite.update()
  pd.timer.updateTimers()
end
