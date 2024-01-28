(local M {})

(lambda M.require-plugins! [ns]
  `(each [_# n# (ipairs ,ns)]
     (require (.. :plugins._ n#))))

(lambda M.fst! [obj]
  `(. ,obj 1))

(lambda M.snd! [obj]
  `(. ,obj 2))

(lambda M.require-then! [module callback]
  `(,callback (require ,module)))

M
