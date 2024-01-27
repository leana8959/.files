(global M {})

(set M.Map (fn [tbl f]
             (let [t {}]
               (each [k v (pairs tbl)] (tset t k (f v)))
               t)))

(set M.Foreach (fn [tbl f]
                 (each [k v (pairs tbl)] (f k v))))

(set M.Contains (fn [tbl elem]
                  (each [_ v (pairs tbl)] (when (= v elem) (lua "return true")))
                  false))

(set M.Filter (fn [tbl pred]
                (let [t {}]
                  (each [k v (pairs tbl)] (when (pred v) (tset t k v)))
                  t)))

(set M.Concat (fn [tbl1 tbl2]
                (let [t {}]
                  (each [k v (pairs tbl1)] (tset t k v))
                  (each [k v (pairs tbl2)] (tset t k v))
                  t)))

M
