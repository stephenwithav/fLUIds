# succ
Easier love-imgui interface for LÖVE inspired by LaTeX TikZ node positioning. (written in MoonScript!)

![preview](https://i.imgur.com/aYZ8nu5.png)

## Installation
* Download the `succ.lua` file inside the `src/` folder of this directory
* Include `succ` by adding `succ = require("succ")` at the top of your `main.lua`
* (If you dislike the name `succ`, you can easily change it via: `somename = require("succ")` - or like, you can get over yourself)

## Example
```lua
succ = require("succ")

function love.load()
  drawable = function() imgui.Text("Hello World!") end

  window_1 = succ.Window("Title", drawable, {10, 10, 300, 40})
  window_2 = succ.Window("Another Title", drawable, {0, 0, 300, 40})

  window_2:setAlign({"left of", "bottom"}, window_1)
end

function love.update(dt)
  -- Apply window related movement stuff here

  -- Update succ last
  succ.Update()
end

function love.draw()
  succ.Draw()
end

function love.quit()
  succ.Quit()
end

-- Inputs
function love.textinput(t)
  succ.textinput(t)
end

function love.keypressed(key)
  succ.keypressed(key)
end

function love.keyreleased(key)
  succ.keyreleased(key)
end

function love.mousemoved(x, y)
  succ.mousemoved(x, y)
end

function love.mousepressed(x, y, button)
  succ.mousepressed(button)
end

function love.mousereleased(x, y, button)
  succ.mousereleased(button)
end

function love.wheelmoved(x, y)
  succ.wheelmoved(x, y)
end
```

## Syntax
### succ.Window()
```lua
succ.Window(title, drawable, config, args)
```
* title (__string__): Title of the window
* drawable (__function__): The imgui widgets, see `drawables`
* config (__table__): Contains x, y, w, h of windows
  - `{x, y, w, h}`
  - Note, `x` and `y` can be set to 0 if using `:setAlign()`
* args (__table__): imgui window arguements, e.g. `{"NoTitleBar", "AlwaysAutoResize"}`

### :setAlign()
```lua
window:setAlign(position, relativeTo)
```
* position (__table__)
  - [1]: Either `"above of"`, `"below of"`, `"left of"`, `"right of"`
  - [2]: Defines vertical/horizontal align depending on `[1]`: `"right"`, `"left"`, `"top"`, `"bottom"`
* relativeTo (__object__): Another succ Window

For example;

```lua
window_1 = succ.Window("", drawable, {10, 20})
window_2 = succ.Window("", drawable)

window_2:setAlign({"below of", "right"}, window_1)
```

Will render: (obviously `drawable` is different...)

![](https://i.imgur.com/438rvfu.png)

### :destroy()
```lua
window = succ.Window("", drawable)
window:destroy()

window = nil
```
Removes the window from succ.

### :detach()
```lua
window = succ.Window("", drawable)
window:setAlign("below of", anotherWindow)

window:detach()
```
Detaches the window from its current attachment.

### succ.ApplyTheme()
```lua
theme = {{"WindowRounding", 0}, {...}}
succ.ApplyTheme(theme)
```
Currently does not support colours.

### succ.SetFont()
```lua
succ.SetFont(font, dimensions)
```
* font (__font object__)