local Game = require("game")

function love.load()
	Game:load()
end

function love.update(dt)
	Game:update(dt)
end

function love.draw()
	Game:draw()
end

function love:keypressed(key)
	if key == "escape" then
		self.event.quit()
	end
end
