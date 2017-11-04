# fLUIds
love-imgui API wrap for simplicity, inspired by LaTeX TikZ node positioning. (written in MoonScript!)

![preview](https://i.imgur.com/aYZ8nu5.png)

## Installation
* Download the `fluids.lua` file inside the `src/` folder of this directory
* Include `fluids` by adding `fluids = require("fluids")` at the top of your `main.lua`

## Example
```lua
fluids = require("fluids")

function love.load()
  drawable = function() imgui.Text("Hello World!") end

  window_1 = fluids.Window("Title", drawable, {10, 10, 300, 40})
  window_2 = fluids.Window("Another Title", drawable, {0, 0, 300, 40})

  window_2:setAlign({"left of", "bottom"}, window_1)
end

function love.update(dt)
  -- Apply window related movement stuff here

  -- Update fluids last
  fluids.Update()
end

function love.draw()
  fluids.Draw()
end

function love.quit()
  fluids.Quit()
end

-- Inputs
function love.textinput(t)
  fluids.textinput(t)
end

function love.keypressed(key)
  fluids.keypressed(key)
end

function love.keyreleased(key)
  fluids.keyreleased(key)
end

function love.mousemoved(x, y)
  fluids.mousemoved(x, y)
end

function love.mousepressed(x, y, button)
  fluids.mousepressed(button)
end

function love.mousereleased(x, y, button)
  fluids.mousereleased(button)
end

function love.wheelmoved(x, y)
  fluids.wheelmoved(x, y)
end
```

## Syntax
### fluids.Window()
```lua
fluids.Window(title, drawable, config, args)
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
* relativeTo (__object__): Another fluids Window

For example;

```lua
window_1 = fluids.Window("", drawable, {10, 20})
window_2 = fluids.Window("", drawable)

window_2:setAlign({"below of", "right"}, window_1)
```

Will render: (obviously `drawable` is different...)

![](https://i.imgur.com/438rvfu.png)

### :destroy()
```lua
window = fluids.Window("", drawable)
window:destroy()

window = nil
```
Removes the window from fluids.

### :detach()
```lua
window = fluids.Window("", drawable)
window:setAlign("below of", anotherWindow)

window:detach()
```
Detaches the window from its current attachment.

### fluids.ApplyTheme()
```lua
theme = {{"WindowRounding", 0}, {...}}
fluids.ApplyTheme(theme)
```
Currently does not support colours.

### fluids.SetFont()
```lua
fluids.SetFont(font, dimensions)
```
* font (__font object__)
