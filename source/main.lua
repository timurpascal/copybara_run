import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "sceneManager"
import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

SCENE_MANAGER = SceneManager()

GameScene()

function pd.update()
	gfx.sprite.update()
	pd.timer.updateTimers()
end
