import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "Player"
import "Obstacle"

local pd <const> = playdate
local gfx <const> = playdate.graphics

local function initialize()
	local capybaraImage = gfx.image.new("images/capybara_base")
	local crocodileImage = gfx.image.new("images/crocodile")
	local playerInstance = Player(100, 200, capybaraImage)
	local crocodileInstance = Obstacle(400, 200, 2, crocodileImage)
	playerInstance:add()
	crocodileInstance:add()
end

initialize()

function pd.update()
	gfx.sprite.update()
	pd.timer.updateTimers()
end
