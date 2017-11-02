require("imgui")
require("moonscript")
io.stdout:setvbuf('no')
local succ = require("succ")
love.load = function()
  local window_func
  window_func = function()
    return imgui.TextWrapped("Qui magna sint anim id sint enim in laborum non sed irure quis id eu culpa occaecat in culpa fugiat quis pariatur quis aliqua ex in fugiat deserunt labore cillum nisi adipisicing sed cillum veniam reprehenderit in dolore minim nisi mollit incididunt ut reprehenderit ut eu culpa reprehenderit irure aliquip laborum anim in sed pariatur eu dolor in esse pariatur aliquip consectetur velit consequat qui dolore minim voluptate qui sit magna et ex laborum veniam sunt do amet non dolore adipisicing in deserunt nostrud elit ullamco ex incididunt elit aliqua labore occaecat excepteur labore consectetur sed velit cupidatat anim sint consectetur aliquip exercitation dolor irure ullamco sunt mollit dolor pariatur sunt duis dolore minim aute proident mollit dolor quis occaecat sunt consequat dolor esse consectetur non in consectetur eiusmod laboris officia exercitation pariatur sed tempor amet esse cillum dolore laborum do do est sed nisi sed irure ullamco proident eu ex culpa et reprehenderit aliqua in ut dolor eiusmod commodo consequat irure velit occaecat id in aliqua dolor laborum proident consectetur enim dolor in non tempor ut laboris non laborum nostrud ut enim aute ea proident nisi dolore magna in esse duis elit aliqua cupidatat ullamco nisi est sit aliqua aute est eu consectetur aliquip ullamco eu sint ad consectetur sed cillum minim cillum consectetur dolor ut aliquip dolore sit ad aliqua aliquip consequat non id esse.")
  end
  local window_func2
  window_func2 = function()
    imgui.Text("self.x: " .. math.floor(window_2.x))
    return imgui.Text("self.y: " .. math.floor(window_2.y))
  end
  local window_func3
  window_func3 = function()
    return imgui.Text("fucking normies")
  end
  local theme = {
    {
      "WindowRounding",
      0
    }
  }
  succ.ApplyTheme(theme)
  window_1 = succ.Window("Window 1", window_func, {
    300,
    100,
    300,
    300
  })
  window_2 = succ.Window("Window 2", window_func2, {
    10,
    100
  })
  window_3 = succ.Window("Window 3", window_func3, {
    0,
    200
  })
  window_2:setAlign({
    "right of",
    "bottom"
  }, window_1)
  return window_3:setAlign({
    "right of"
  }, window_2)
end
love.update = function(dt)
  window_1.x = window_1.x - 1
  window_1.y = window_1.y + 0.5
  return succ.Update()
end
love.draw = function()
  love.graphics.setBackgroundColor(100, 100, 100)
  return succ.Draw()
end
love.keypressed = function(key)
  local _exp_0 = key
  if "w" == _exp_0 then
    return succ.ToggleVisibliity(window_2)
  elseif "d" == _exp_0 then
    return window_2:detach()
  end
end