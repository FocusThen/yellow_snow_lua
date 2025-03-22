local PLAYER_Y = 378
local PLAYER_SPEED = 300
local X_OFF_SET = 47
local TOP_OFFSET = 12

local Player = {
	_is_right = true,
}

function Player:new(image)
	local newPlayer = {}
	newPlayer._image = image
	newPlayer._width, newPlayer._height = image:getDimensions()
	newPlayer._x = (love.graphics.getWidth() - newPlayer._width) / 2

	setmetatable(newPlayer, { __index = self })
	return newPlayer
end

function Player:left()
	return self._x + X_OFF_SET
end

function Player:right()
	return self._x + self._width - X_OFF_SET
end

function Player.top()
  return PLAYER_Y + TOP_OFFSET
end

function Player:update(dt)
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		self._is_right = false
		self._x = self._x - PLAYER_SPEED * dt
		if self:left() < 0 then
			self._x = -X_OFF_SET
		end
	end
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		self._is_right = true
		self._x = self._x + PLAYER_SPEED * dt
		if self:right() > love.graphics.getWidth() then
			self._x = love.graphics.getWidth() + X_OFF_SET - self._width
		end
	end
end

function Player:draw()
	if self._is_right then
		love.graphics.draw(self._image, self._x, PLAYER_Y, 0, 1, 1)
	else
		love.graphics.draw(self._image, self._x + self._width, PLAYER_Y, 0, -1, 1)
	end
end

return Player
