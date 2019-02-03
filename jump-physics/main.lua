-- DEBUG INFO
debug = true

-- PLAYER INFO
platform = { x = 0, y = 400, w = 800, h = 80 }
last_dt = 0

players = { 
  { x = 50, y = 370, w = 20, h = 30, mass = 50 , yVelocity = 0, isJumping = false, color = { 0.6, 0, 0 } },
  { x = 100, y = 370, w = 20, h = 30, mass = 80 , yVelocity = 0, isJumping = false, color = { 0, 0.6, 0 } },
  { x = 150, y = 370, w = 20, h = 30, mass = 100 , yVelocity = 0, isJumping = false, color = { 0, 0, 0.6 } }
}

-- ============ LOVE CALLBACKS ===============

function love.load(arg)
  
end

function love.update(dt)
  last_dt = dt

  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  if love.keyboard.isDown('up') then
    for i, player in ipairs(players) do
      if not player.isJumping then
        player.isJumping = true
        impulse = -10000
        player.yVelocity = impulse / player.mass
      end
    end
  end

  for i, player in ipairs(players) do
    if player.isJumping then
      player.yVelocity = player.yVelocity + delta_v(dt)

      dd = dt * player.yVelocity
      if player.y + dd >= platform.y - player.h then
        player.yVelocity = 0
        player.isJumping = false
        player.y = platform.y - player.h
      else
        player.y = player.y + dd
      end
    end
  end
end

function love.draw(dt)
  love.graphics.setColor(0.5, 0.5, 0.5)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.w, platform.h)

  for i, player in ipairs(players) do
    love.graphics.setColor(player.color)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
    love.graphics.print(player.yVelocity, player.x, 400)
    love.graphics.print((player.isJumping and "true" or "false"), player.x, 430)
    love.graphics.print(player.mass, player.x, 450)
  end
end

-- ============== FUNCTIONS ====================

function delta_v(dt)
  return dt * 500
end