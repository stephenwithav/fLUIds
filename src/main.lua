require("imgui")
require("moonscript")
io.stdout:setvbuf('no')
local fluids = require("fluids")
love.load = function()
  local image = love.graphics.newImage("image.png")
  local window_func
  window_func = function()
    return imgui.TextWrapped("Qui magna sint anim id sint enim in laborum non sed irure quis id eu culpa occaecat in culpa fugiat quis pariatur quis aliqua ex in fugiat deserunt labore cillum nisi adipisicing sed cillum veniam reprehenderit in dolore minim nisi mollit incididunt ut reprehenderit ut eu culpa reprehenderit irure aliquip laborum anim in sed pariatur eu dolor in esse pariatur aliquip consectetur velit consequat qui dolore minim voluptate qui sit magna et ex laborum veniam sunt do amet non dolore adipisicing in deserunt nostrud elit ullamco ex incididunt elit aliqua labore occaecat excepteur labore consectetur sed velit cupidatat anim sint consectetur aliquip exercitation dolor irure ullamco sunt mollit dolor pariatur sunt duis dolore minim aute proident mollit dolor quis occaecat sunt consequat dolor esse consectetur non in consectetur eiusmod laboris officia exercitation pariatur sed tempor amet esse cillum dolore laborum do do est sed nisi sed irure ullamco proident eu ex culpa et reprehenderit aliqua in ut dolor eiusmod commodo consequat irure velit occaecat id in aliqua dolor laborum proident consectetur enim dolor in non tempor ut laboris non laborum nostrud ut enim aute ea proident nisi dolore magna in esse duis elit aliqua cupidatat ullamco nisi est sit aliqua aute est eu consectetur aliquip ullamco eu sint ad consectetur sed cillum minim cillum consectetur dolor ut aliquip dolore sit ad aliqua aliquip consequat non id esse.")
  end
  local window_func2
  window_func2 = function()
    imgui.Text("self.x: " .. math.floor(window_2.x))
    imgui.Text("self.y: " .. math.floor(window_2.y))
    return imgui.Text("FPS: " .. love.timer.getFPS())
  end
  local window_func3
  window_func3 = function()
    return imgui.Image(image, image:getWidth() / 4, image:getHeight() / 4)
  end
  local theme = {
    {
      "WindowRounding",
      0
    }
  }
  fluids.ApplyTheme(theme)
  window_1 = fluids.Window("Window 1", window_func, {
    200,
    200,
    300,
    300
  })
  window_2 = fluids.Window("Window 2", window_func2)
  window_3 = fluids.Window("Window 3", window_func3, {
    0,
    0,
    150,
    150
  })
  window_2:setAlign({
    "right of",
    "bottom"
  }, window_1)
  window_3:setAlign({
    "above of",
    "right"
  }, window_2)
  return fluids.Window("No name", window_func, {
    10,
    10,
    300,
    100
  })
end
love.update = function(dt)
  fluids.Update()
  if love.filesystem.exists("lovebird.lua") then
    return require("lovebird").update()
  end
end
love.draw = function()
  love.graphics.setBackgroundColor(100, 100, 100)
  return fluids.Draw()
end
love.textinput = function(t)
  return fluids.textinput(t)
end
love.keypressed = function(key)
  fluids.keypressed(key)
  local _exp_0 = key
  if "w" == _exp_0 then
    return fluids.ToggleVisibliity(window_2)
  elseif "d" == _exp_0 then
    return window_2:detach()
  elseif "f" == _exp_0 then
    return window_1:destroy()
  elseif "q" == _exp_0 then
    fluids.Quit()
    return love.event.quit()
  end
end
love.keyreleased = function(key)
  return fluids.keyreleased(key)
end
love.mousemoved = function(x, y)
  return fluids.mousemoved(x, y)
end
love.mousepressed = function(x, y, button)
  return fluids.mousepressed(button)
end
love.mousereleased = function(x, y, button)
  return fluids.mousereleased(button)
end
love.wheelmoved = function(x, y)
  return fluids.wheelmoved(x, y)
end
