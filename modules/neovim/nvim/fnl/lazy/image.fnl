;; fnl/lazy/image.fnl
{1 :image.nvim
 :ft :markdown
 :after (fn []
          ((. (require :image) :setup) {:integrations {:markdown {:only_render_image_at_cursor true}}}))}
