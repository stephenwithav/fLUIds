require "imgui"
require "moonscript"
io.stdout\setvbuf('no')

succ = require "succ"

love.load = () ->
  window_func = () ->
    imgui.TextWrapped("Qui magna sint anim id sint enim in laborum non sed irure quis id eu culpa occaecat in culpa fugiat quis pariatur quis aliqua ex in fugiat deserunt labore cillum nisi adipisicing sed cillum veniam reprehenderit in dolore minim nisi mollit incididunt ut reprehenderit ut eu culpa reprehenderit irure aliquip laborum anim in sed pariatur eu dolor in esse pariatur aliquip consectetur velit consequat qui dolore minim voluptate qui sit magna et ex laborum veniam sunt do amet non dolore adipisicing in deserunt nostrud elit ullamco ex incididunt elit aliqua labore occaecat excepteur labore consectetur sed velit cupidatat anim sint consectetur aliquip exercitation dolor irure ullamco sunt mollit dolor pariatur sunt duis dolore minim aute proident mollit dolor quis occaecat sunt consequat dolor esse consectetur non in consectetur eiusmod laboris officia exercitation pariatur sed tempor amet esse cillum dolore laborum do do est sed nisi sed irure ullamco proident eu ex culpa et reprehenderit aliqua in ut dolor eiusmod commodo consequat irure velit occaecat id in aliqua dolor laborum proident consectetur enim dolor in non tempor ut laboris non laborum nostrud ut enim aute ea proident nisi dolore magna in esse duis elit aliqua cupidatat ullamco nisi est sit aliqua aute est eu consectetur aliquip ullamco eu sint ad consectetur sed cillum minim cillum consectetur dolor ut aliquip dolore sit ad aliqua aliquip consequat non id esse.")
  window_func2 = () ->
    imgui.Text("self.x: " .. math.floor(window_2.x))
    imgui.Text("self.y: " .. math.floor(window_2.y))
  window_func3 = () ->
    imgui.Text("fucking normies")


  theme = {
    {"WindowRounding", 0},
  }
  succ.ApplyTheme(theme)

  export window_1 = succ.Window("Window 1", window_func, {300, 100, 300, 300})
  export window_2 = succ.Window("Window 2", window_func2, {10, 100})
  export window_3 = succ.Window("Window 3", window_func3, {0, 200})

  window_2\setAlign({"right of", "bottom"}, window_1)
  window_3\setAlign({"right of"}, window_2)

love.update = (dt) ->
  window_1.x -= 1
  window_1.y += 0.5

  succ.Update()

love.draw = () ->
  love.graphics.setBackgroundColor(100,100,100)
  succ.Draw()

love.keypressed = (key) ->
  switch key
    when "w"
      succ.ToggleVisibliity(window_2)
    when "d"
      window_2\detach()
