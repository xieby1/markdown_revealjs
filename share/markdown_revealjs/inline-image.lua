-- TODO: enhance tonumber to handle '%' for scale and clip
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

    local img_width
    local img_height
    local div_content
    if ext == "svg" then
      -- svg = "<svg ...>...</svg>"
      div_content = (function() -- begin of a local scope
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
      img_width = string.match(div_content, '<svg[^>]*width=["\']?([^ >"\']*)')
      img_height = string.match(div_content, '<svg[^>]*height=["\']?([^ >"\']*)')
    else
      return nil -- This means that the pandoc object should remain unchanged.
    end

    local scale=1
    if img.attr.attributes.scale then
      scale = tonumber(img.attr.attributes.scale)
    elseif img.attr.attributes.width then
      scale = to_px(img.attr.attributes.width) / to_px(img_width)
    elseif img.attr.attributes.height then
      scale = to_px(img.attr.attributes.height) / to_px(img_height)
    end
    local gradient = img.attr.attributes.gradient or 10

    local html_content = string.format(
      [[<div style="transform:scale(%f);
        margin:%fpx %fpx;
        display:flex; justify-content:center;"
      >%s</div>]],
      scale, (scale-1)/2*to_px(img_height), (scale-1)/2*to_px(img_width), div_content
    )

    local width = scale * to_px(img_width)
    local height = scale * to_px(img_height)
    if img.attr.attributes.clip then
      local t,r,b,l = string.match(img.attr.attributes.clip, '(%d+)%%%s*(%d+)%%%s*(%d+)%%%s*(%d+)%%')
      t=tonumber(t); r=tonumber(r); b=tonumber(b); l=tonumber(l);
      -- print("clip: ", t, r, b, l)
      html_content = string.format(
        [[<div style="display:flex; justify-content:center;">
          <div style="overflow:hidden; width:%fpx; height:%fpx;
            mask-mode:alpha; mask-composite:intersect;%s
          ">
          <div style="transform:translate(%fpx,%fpx); width:%fpx; height:%fpx;">
          %s
          </div>
          </div>
          </div>]],
        width*(r-l)/100, height*(b-t)/100,
        (function ()
          local gradients = {}
          local template = "linear-gradient(to %s,transparent 0%%, black %d%%)"
          if t~=0 then   table.insert(gradients, string.format(template, "bottom", gradient)) end
          if r~=100 then table.insert(gradients, string.format(template, "left",   gradient)) end
          if b~=100 then table.insert(gradients, string.format(template, "top",    gradient)) end
          if l~=0 then   table.insert(gradients, string.format(template, "right",  gradient)) end
          local gradients_str = table.concat(gradients, ",")
          if gradients_str ~= "" then
            gradients_str = string.format("mask-image:%s;", gradients_str)
          end
          -- print(gradients_str)
          return gradients_str
        end)(),
        width*( -l)/100, height*( -t)/100, width, height,
        html_content
      )
    end
    inlines[1] = pandoc.RawInline("html", html_content)
  end
  return inlines
end
