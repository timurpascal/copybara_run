import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "Capybara"
import "Obstacle"

local pd <const> = playdate
local gfx <const> = playdate.graphics

local function initialize()
	local crocodileImage = gfx.image.new("images/crocodile")
	local playerInstance = Capybara(100, 200)
	local crocodileInstance = Obstacle(400, 200, 2, crocodileImage)
	playerInstance:add()
	crocodileInstance:add()
end

initialize()

function pd.update()
	gfx.sprite.update()
	pd.timer.updateTimers()
end
