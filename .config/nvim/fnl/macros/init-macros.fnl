(local M {})

(lambda M.require-plugins! [ns]
  `(each [_# n# (ipairs ,ns)]
     (require (.. :plugins._ n#))))

M
