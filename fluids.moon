export fluids = {
  clients: {},
  theme: {}
}
class Window
  new: (title, drawable, config, args) =>
    @title = title
    @drawable = drawable
    @args = args or {}
    config = config or {}
    @x, @y = config[1] or 0, config[2] or 0
    @w, @h = config[3] or 200, config[4] or 100
    @visible = true
    fluids.clients[#fluids.clients+1] = self

  setAlign: (position, to) =>
    @position = position
    @to = to
    @attached = true

  calcAlign: () =>
    switch @position[1]
      when "left of"
        @x = @to.x-@w
        @y = @to.y
      when "right of"
        @x = @to.x+@to.w
        @y = @to.y
      when "above of"
        @y = @to.y-@h
        @x = @to.x
      when "below of"
        @y = @to.y+@to.h
        @x = @to.x

    switch @position[1]
      when "left of" or "right of"
        switch @position[2]
          when "@top"
            @y = @to.y
          when "bottom"
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

  destroy: () =>
    for k, client in pairs(fluids.clients) do
      if client == self
        -- Detach all children from their parent
        for k, child in pairs fluids.clients do
          if self == child.to
            child\detach()
        table.remove(fluids.clients, k)
        self = nil
        return

fluids.Window = Window

fluids.Draw = () ->
  -- Push all the styles
  for _, style in pairs fluids.theme do
    imgui.PushStyleVar(style[1], style[2])

  -- Draw all the styles (if visible)
  for _, client in pairs fluids.clients do
    if client.visible then
      if not fluids.clicking
        imgui.SetNextWindowPos(client.x, client.y)
      else
        if client.attached
          imgui.SetNextWindowPos(client.x, client.y)
      imgui.SetNextWindowSize(client.w, client.h, "FirstUseEver")
      status, client.visible = imgui.Begin(client.title, true, {unpack(client.args)})
      if fluids.clicking
        client.x, client.y = imgui.GetWindowPos()
        if client.attached
          client.x = client.to.x
          client.y = client.to.y
      client.drawable()
      imgui.End()

  -- Pop out all the styles
  imgui.PopStyleVar(#fluids.theme)
  imgui.Render()

fluids.Update = () ->
  imgui.NewFrame()
  for _, client in pairs fluids.clients do
    if client.attached and client.to ~= nil
      client\calcAlign(client.position, client.to)

fluids.ApplyTheme = (theme) ->
  for _, style in pairs(theme) do
    table.insert(fluids.theme, style)

fluids.ToggleVisibliity = (client) ->
  client.visible = not client.visible

fluids.SetFont = (font, dimensions) ->
  imgui.SetGlobalFontFromFileTTF(font, unpack(dimensions))

fluids.Quit = () ->
  imgui.ShutDown()

fluids.textinput = (t) ->
  imgui.TextInput(t)

fluids.keypressed = (key) ->
  imgui.KeyPressed(key)

fluids.keyreleased = (key) ->
  imgui.KeyReleased(key)

fluids.mousemoved = (x, y) ->
  imgui.MouseMoved(x, y)

fluids.mousepressed = (button) ->
  fluids.clicking = true
  imgui.MousePressed(button)

fluids.mousereleased = (button) ->
  fluids.clicking = false
  imgui.MouseReleased(button)

fluids.wheelmoved = (x, y) ->
  imgui.WheelMoved(y)

return fluids