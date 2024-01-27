(local M {})

(lambda M.require-then [module callback]
  (callback (require module)))

(lambda M.fst [obj]
  (. obj 1))

(lambda M.snd [obj]
  (. obj 2))

M
