succ = {
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
      for k, client in ipairs(succ.clients) do
        if client == self then
          table.remove(succ.clients, k)
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
      succ.clients[#succ.clients + 1] = self
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
succ.Window = Window
succ.Draw = function()
  for _, style in pairs(succ.theme) do
    imgui.PushStyleVar(style[1], style[2])
  end
  for _, client in pairs(succ.clients) do
    if client.visible then
      imgui.SetNextWindowPos(client.x, client.y, "FirstUseEver")
      imgui.SetNextWindowSize(client.w, client.h, "FirstUseEver")
      local status
      status, client.visible = imgui.Begin(client.title, true, unpack(client.args))
      client.drawable()
      imgui.End()
    end
  end
  imgui.PopStyleVar(#succ.theme)
  return imgui.Render()
end
succ.Update = function()
  imgui.NewFrame()
  for _, client in pairs(succ.clients) do
    if client.attached then
      client:calcAlign(client.position, client.to)
    end
  end
end
succ.ApplyTheme = function(theme)
  for _, style in pairs(theme) do
    table.insert(succ.theme, style)
  end
end
succ.ToggleVisibliity = function(client)
  client.visible = not client.visible
end
succ.SetFont = function(font, dimensions)
  return imgui.SetGlobalFontFromFileTTF(font, unpack(dimensions))
end
succ.Quit = function()
  return imgui.ShutDown()
end
succ.textinput = function(t)
  return imgui.TextInput(t)
end
succ.keypressed = function(key)
  return imgui.KeyPressed(key)
end
succ.keyreleased = function(key)
  return imgui.KeyReleased(key)
end
succ.mousemoved = function(x, y)
  return imgui.MouseMoved(x, y)
end
succ.mousepressed = function(button)
  return imgui.MousePressed(button)
end
succ.mousereleased = function(button)
  return imgui.MouseReleased(button)
end
succ.wheelmoved = function(x, y)
  return imgui.WheelMoved(y)
end
return succ
