local function to_px(value_unit)
  local value = tonumber(string.match(value_unit, "%d+"))
  local unit = string.match(value_unit, "%a+")
  -- print(string.format("value_unit %s, value %d, unit %s", value_unit, value, unit))
  if unit == "cm" then
    value = value * 25.2 / 64
  elseif unit == "mm" then
    value = value * 25.2 / 64 / 10
  elseif unit == "Q" then
    value = value * 25.2 / 64 / 40
  elseif unit == "in" then
    value = value
  elseif unit == "pc" then
    value = value / 6
  elseif unit == "pt" then
    value = value / 72
  elseif unit == "px" then
    value = value / 96
  end
  return value * 96
end
function Inlines(inlines)
  if #inlines==1 and inlines[1].tag=="Image" then
    local img = inlines[1]
    local ext = string.sub(img.src, -3, -1)

    if ext == "svg" then
      -- svg = "<svg ...>...</svg>"
      local svg = (function() -- begin of a local scope
        -- handle ~ in img.src
        local path = img.src
        if string.sub(path, 1, 1) == "~" then
          path = os.getenv("HOME") .. string.sub(path, 2)
        end

        local file = io.open(path, "r")
        if not file then return "inline-image.lua: NOT FOUND: " .. img.src end
        local content = file:read("*a")
        file:close()
        -- Pattern to match the entire <svg> tag and its content
        return content:match("<svg.*</svg>")
      end) () -- end of a local scope
      local svg_width = string.match(svg, '<svg[^>]*width=["\']?([^ >"\']*)')
      local svg_height = string.match(svg, '<svg[^>]*height=["\']?([^ >"\']*)')
      local scale=1
      if img.attr.attributes.width then
        scale = to_px(img.attr.attributes.width) / to_px(svg_width)
      elseif img.attr.attributes.height then
        scale = to_px(img.attr.attributes.height) / to_px(svg_height)
      end
      inlines[1] = pandoc.RawInline("html", string.format(
        '<div style="transform:scale(%f); margin:%fpx %fpx; display:flex;justify-content:center;">%s</div>',
        scale, (scale-1)/2*to_px(svg_width), (scale-1)/2*to_px(svg_height), svg
      ))
    end
  end
  return inlines
end
