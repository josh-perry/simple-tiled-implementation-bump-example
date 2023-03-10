local sti = require("lib.sti")
local bump = require("lib.bump")

local map
local world
local player

function love.load()
	world = bump.newWorld(16)

	map = sti("map1.lua", { "bump" })
	map:bump_init(world)

	player = {
		x = 128,
		y = 64,
		w = 16,
		h = 16,
		speed = 64
	}

	world:add(player, player.x, player.y, player.w, player.h)
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	map:draw()

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)

	if love.keyboard.isDown("space") then
		love.graphics.setColor(1, 0, 0)
		map:bump_draw()
	end
end

function love.update(dt)
	do
		local dx, dy = 0, 0

		if love.keyboard.isDown("right") then
			dx = player.speed * dt
		elseif love.keyboard.isDown("left") then
			dx = -player.speed * dt
		end

		if love.keyboard.isDown("down") then
			dy = player.speed * dt
		elseif love.keyboard.isDown("up") then
			dy = -player.speed * dt
		end

		if dx ~= 0 or dy ~= 0 then
			player.x, player.y = world:move(player, player.x + dx, player.y + dy)
		end
	end

	map:update(dt)
end
