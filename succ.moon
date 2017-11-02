export succ = {}
succ.clients = {}
succ.theme = {}
class Window
  new: (title, drawable, config, args) =>
    @title = title
    @drawable = drawable
    @args = args or {}
    @x, @y = config[1] or 0, config[2] or 0
    @w, @h = config[3] or 200, config[4] or 100
    @visible = true
    table.insert(succ.clients, self)

  setAlign: (position, to) =>
    @position = position
    @to = to
    @attached = true

  calcAlign: () =>
    switch @position[1]
      when "left of"
        @x = @to.x-@w
      when "right of"
        @x = @to.x+@to.w
      when "above of"
        @y = @to.y-@h
      when "below of"
        @y = @to.y+@to.h

    switch @position[1]
      when "left of" or "right of"
        switch @position[2]
          when "@top"
            @y = @to.y
          when "bot@tom"
            @y = (@to.y+@to.h)-@h
      when "below of" or "above of"
        switch @position[2]
          when "left"
            @x = @to.x
          when "right"
            @x = (@to.x+@to.w)-@w

  detach: () =>
    @attached = false
    @position = nil
    @to = nil

succ.Draw = () ->
  -- Push all the styles
  for _, style in pairs succ.theme do
    imgui.PushStyleVar(style[1], style[2])

  -- Draw all the styles (if visible)
  for _, client in pairs succ.clients do
    if client.visible then
      imgui.SetNextWindowPos(client.x, client.y)
      imgui.SetNextWindowSize(client.w, client.h)
      status, client.visible = imgui.Begin(client.title, true, unpack(client.args))
      client.drawable()
      imgui.End()

  -- Pop out all the styles
  for i=1, #succ.theme do
    imgui.PopStyleVar()
  imgui.Render()

succ.Update = () ->
  imgui.NewFrame()
  for _, client in pairs succ.clients do
    if client.attached
      client\calcAlign(client.position, client.to)

succ.ApplyTheme = (theme) ->
  for _, style in pairs(theme) do
    table.insert(succ.theme, style)

succ.ToggleVisibliity = (client) ->
  client.visible = not client.visible

succ.SetFont = (font, dimensions) ->
  imgui.SetGlobalFontFromFileTTF(font, unpack(dimensions))

succ.Quit = () ->
  imgui.ShutDown()

succ.textinput = (t) ->
  imgui.TextInput(t)

succ.keypressed = (key) ->
  imgui.KeyPressed(key)

succ.keyreleased = (key) ->
  imgui.KeyReleased(key)

succ.mousemoved = (x, y) ->
  imgui.MouseMoved(x, y)

succ.mousepressed = (x, y, button) ->
  imgui.MousePressed(button)

succ.mousereleased = (x, y, button) ->
  imgui.MouseReleased(button)

succ.wheelmoved = (x, y) ->
  imgui.WheelMoved(y)


succ.Window = Window
return succ