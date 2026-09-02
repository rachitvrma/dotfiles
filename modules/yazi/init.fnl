; function Linemode:size_and_mtime()
;   local time = math.floor(self._file.cha.mtime or 0)
;   if time == 0 then
;     time = ''
;   elseif os.date('%Y', time) == os.date('%Y') then
;     time = os.date('%b %d %H:%M', time)
;   else
;     time = os.date('%b %d  %Y', time)
;   end
;
;   local size = self._file:size()
;   return string.format('%s %s', size and ya.readable_size(size) or '-', time)
; end

;; NOTE: This is not the file getting symlinked, so don't try to link to
;; any xdg config file.
(fn Linemode.size_and_mtime [self]
  (var time (math.floor (or self._file.cha.mtime 0)))
  (if (= time 0)
      (set time "")
      (= (os.date "%Y" time) (os.date "%Y"))
      (set time (os.date "%b %d %H:%M" time))
      (set time (os.date "%b %d  %Y" time)))
  (let [size (self._file:size)]
    (string.format "%s %s" (if size (ya.readable_size size) "-") time)))
