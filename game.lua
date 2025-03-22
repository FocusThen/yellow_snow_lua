local Player = require("player")
local Flake = require("flake")

local Game = {
	_is_playing = true,
	_score = 0,
}

function Game:load()
	math.randomseed(os.time())

	self.background_image = love.graphics.newImage("images/background.png")
	self.player_image = love.graphics.newImage("images/player.png")
	self.flake_white = love.graphics.newImage("images/white.png")
	self.flake_yellow = love.graphics.newImage("images/yellow.png")

	-- sounds
	self.collect = love.audio.newSource("sounds/collect.ogg", "static")
	self.hit = love.audio.newSource("sounds/hit.ogg", "static")
	self.music = love.audio.newSource("music/winter_loop.ogg", "stream")

	-- font
	self.font = love.graphics.newFont("fonts/freesansbold.ttf", 24)
	love.graphics.setFont(self.font)

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
		local flake = Flake:new(self.flake_white, true)
		flake:reset(true)
		table.insert(self.flakes, flake)
	end

	-- Play background music
	self.music:setLooping(true)
	self.music:play()
end

function Game:isPlaying()
	return self._is_playing
end

function Game:reset()
	self._score = 0
	for _, flake in ipairs(self.flakes) do
		flake:reset(true)
	end
	self._is_playing = true
	self.music:play()
end

function Game:checkCollision(flake)
	if
		flake:bottom() > self.player:top()
		and flake:right() > self.player:left()
		and flake:left() < self.player:right()
	then
		if flake:isWhite() then
			self.collect:clone():play()
			flake:reset(false)
			self._score = self._score + 1
		else
			self.hit:clone():play()
			self._is_playing = false
	self.music:stop()
		end
	end
end

function Game:update(dt)
	if self:isPlaying() then
		self.player:update(dt)
		for _, flake in ipairs(self.flakes) do
			flake:update(dt)
			self:checkCollision(flake)
		end
	end
end

function Game:draw()
	love.graphics.draw(self.background_image)
	self.player:draw()
	for _, flake in ipairs(self.flakes) do
		flake:draw()
	end
	love.graphics.print("Score: " .. self._score, 10, 10)
end

return Game
