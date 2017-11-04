fluids = {
  clients = { },
  theme = { }
}
local Window
do
  local _class_0
  local _base_0 = {
    setAlign = function(self, position, to)
      self.position = position
      self.to = to
      self.attached = true
    end,
    calcAlign = function(self)
      local _exp_0 = self.position[1]
      if "left of" == _exp_0 then
        self.x = self.to.x - self.w
        self.y = self.to.y
      elseif "right of" == _exp_0 then
        self.x = self.to.x + self.to.w
        self.y = self.to.y
      elseif "above of" == _exp_0 then
        self.y = self.to.y - self.h
        self.x = self.to.x
      elseif "below of" == _exp_0 then
        self.y = self.to.y + self.to.h
        self.x = self.to.x
      end
      local _exp_1 = self.position[1]
      if ("left of" or "right of") == _exp_1 then
        local _exp_2 = self.position[2]
        if "@top" == _exp_2 then
          self.y = self.to.y
        elseif "bottom" == _exp_2 then
          self.y = (self.to.y + self.to.h) - self.h
        end
      elseif ("below of" or "above of") == _exp_1 then
        local _exp_2 = self.position[2]
        if "left" == _exp_2 then
          self.x = self.to.x
        elseif "right" == _exp_2 then
          self.x = (self.to.x + self.to.w) - self.w
        end
      end
    end,
    detach = function(self)
      self.attached = false
      self.position = nil
      self.to = nil
    end,
    destroy = function(self)
      for k, client in pairs(fluids.clients) do
        if client == self then
          for k, child in pairs(fluids.clients) do
            if self == child.to then
              child:detach()
            end
          end
          table.remove(fluids.clients, k)
          self = nil
          return 
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, title, drawable, config, args)
      self.title = title
      self.drawable = drawable
      self.args = args or { }
      config = config or { }
      self.x, self.y = config[1] or 0, config[2] or 0
      self.w, self.h = config[3] or 200, config[4] or 100
      self.visible = true
      fluids.clients[#fluids.clients + 1] = self
    end,
    __base = _base_0,
    __name = "Window"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Window = _class_0
end
fluids.Window = Window
fluids.Draw = function()
  for _, style in pairs(fluids.theme) do
    imgui.PushStyleVar(style[1], style[2])
  end
  for _, client in pairs(fluids.clients) do
    if client.visible then
      if not fluids.clicking then
        imgui.SetNextWindowPos(client.x, client.y)
      else
        if client.attached then
          imgui.SetNextWindowPos(client.x, client.y)
        end
      end
      imgui.SetNextWindowSize(client.w, client.h, "FirstUseEver")
      local status
      status, client.visible = imgui.Begin(client.title, true, {
        unpack(client.args)
      })
      if fluids.clicking then
        client.x, client.y = imgui.GetWindowPos()
        if client.attached then
          client.x = client.to.x
          client.y = client.to.y
        end
      end
      client.drawable()
      imgui.End()
    end
  end
  imgui.PopStyleVar(#fluids.theme)
  return imgui.Render()
end
fluids.Update = function()
  imgui.NewFrame()
  for _, client in pairs(fluids.clients) do
    if client.attached and client.to ~= nil then
      client:calcAlign(client.position, client.to)
    end
  end
end
fluids.ApplyTheme = function(theme)
  for _, style in pairs(theme) do
    table.insert(fluids.theme, style)
  end
end
fluids.ToggleVisibliity = function(client)
  client.visible = not client.visible
end
fluids.SetFont = function(font, dimensions)
  return imgui.SetGlobalFontFromFileTTF(font, unpack(dimensions))
end
fluids.Quit = function()
  return imgui.ShutDown()
end
fluids.textinput = function(t)
  return imgui.TextInput(t)
end
fluids.keypressed = function(key)
  return imgui.KeyPressed(key)
end
fluids.keyreleased = function(key)
  return imgui.KeyReleased(key)
end
fluids.mousemoved = function(x, y)
  return imgui.MouseMoved(x, y)
end
fluids.mousepressed = function(button)
  fluids.clicking = true
  return imgui.MousePressed(button)
end
fluids.mousereleased = function(button)
  fluids.clicking = false
  return imgui.MouseReleased(button)
end
fluids.wheelmoved = function(x, y)
  return imgui.WheelMoved(y)
end
return fluids
