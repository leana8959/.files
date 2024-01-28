(local M {})

(lambda M.map [tbl f]
  (let [t {}]
    (each [k v (pairs tbl)] (tset t k (f v)))
    t))

(lambda M.foreach [tbl f]
  (each [k v (pairs tbl)] (f k v)))

(lambda M.contains [tbl elem]
  (each [_ v (pairs tbl)] (when (= v elem) (lua "return true")) false))

(lambda M.filter [tbl pred]
  (let [t {}]
    (each [k v (pairs tbl)] (when (pred v) (tset t k v)))
    t))

(lambda M.concat [tbl1 tbl2]
  (let [t {}]
    (each [k v (pairs tbl1)] (tset t k v))
    (each [k v (pairs tbl2)] (tset t k v))
    t))

M
