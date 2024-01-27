(local M {})

(lambda M.require-then [module callback]
  (callback (require module)))

M
