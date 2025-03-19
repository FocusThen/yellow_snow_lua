local Player = require("player")
local Flake = require("flake")

local Game = {}

function Game:load()
	math.randomseed(os.time())

	self.background_image = love.graphics.newImage("images/background.png")
	self.player_image = love.graphics.newImage("images/player.png")
	self.flake_white = love.graphics.newImage("images/white.png")
	self.flake_yellow = love.graphics.newImage("images/yellow.png")

	-- player
	self.player = Player:new(self.player_image)

	-- generate list flakes
	self.flakes = {}
	for _ = 1, 5 do
		local flake = Flake:new(self.flake_yellow, false)
		flake:reset(true)
		table.insert(self.flakes, flake)
	end

	for _ = 1, 5 do
		local flake = Flake:new(self.flake_white, false)
		flake:reset(true)
		table.insert(self.flakes, flake)
	end
end

function Game:update(dt)
	self.player:update(dt)
	for _, flake in ipairs(self.flakes) do
		flake:update(dt)
	end
end

function Game:draw()
	love.graphics.draw(self.background_image)
	self.player:draw()
	for _, flake in ipairs(self.flakes) do
		flake:draw()
	end
end

return Game
