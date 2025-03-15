local Player = require("player")
local Game = {}

function Game:load()
	self.background_image = love.graphics.newImage("images/background.png")
	self.player_image = love.graphics.newImage("images/player.png")

	-- player
	self.player = Player:new(self.player_image)
end

function Game:update(dt)
	self.player:update(dt)
end

function Game:draw()
	love.graphics.draw(self.background_image)
	self.player:draw()
end

return Game
