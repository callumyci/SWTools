-- underline-to-italic.lua
function Underline(elem)
  -- Check if the element is already italicized
  if elem.content and #elem.content == 1 and elem.content[1].t == "Emph" then
    return elem.content[1]  -- Return the existing italicized content
  else
    -- Convert underlined text to italic
    local emph = pandoc.Emph(elem.content)
    return emph
  end
end