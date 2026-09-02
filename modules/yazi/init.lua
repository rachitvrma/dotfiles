-- [nfnl] init.fnl
Linemode.size_and_mtime = function(self)
  local time = math.floor((self._file.cha.mtime or 0))
  if (time == 0) then
    time = ""
  elseif (os.date("%Y", time) == os.date("%Y")) then
    time = os.date("%b %d %H:%M", time)
  else
    time = os.date("%b %d  %Y", time)
  end
  local size = self._file:size()
  local _2_
  if size then
    _2_ = ya.readable_size(size)
  else
    _2_ = "-"
  end
  return string.format("%s %s", _2_, time)
end
return Linemode.size_and_mtime
