function Inlines(inlines)
  if #inlines==1 and inlines[1].tag=="Image" then
    local img = inlines[1]
    local ext = string.sub(img.src, -3, -1)

    if ext == "svg" then
      inlines[1] = pandoc.RawInline("html", string.format(
        '<div>%s</div>',
        (function() -- begin of a local scope
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
      ))
    end
  end
  return inlines
end
