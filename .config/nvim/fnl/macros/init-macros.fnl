(local M {})

(lambda M.req-plugins! [ns]
  `(each [_# n# (ipairs ,ns)]
     (require (.. :plugins._ n#))))

(lambda M.fst! [obj]
  `(. ,obj 1))

(lambda M.snd! [obj]
  `(. ,obj 2))

(lambda M.req-do! [module callback]
  `(,callback (require ,module)))

(lambda M.elem! [obj tbl]
  `(each [_# v# (pairs ,tbl)]
     (when (= v# ,obj) (lua "return true"))
     false))

M
