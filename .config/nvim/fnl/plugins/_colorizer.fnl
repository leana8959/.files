(import-macros {: require-then!} :macros)

(let [default {;;#RGB hex codes 
               :RGB true
               ;;#RRGGBB hex codes 
               :RRGGBB true
               ;;"Name" codes like Blue or blue 
               :names false
               ;;#RRGGBBAA hex codes 
               :RRGGBBAA false
               ;;0xAARRGGBB hex codes 
               :AARRGGBB false
               ;;CSS rgb() and rgba() functions 
               :rgb_fn false
               ;;CSS hsl() and hsla() functions 
               :hsl_fn false
               ;;Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB 
               :css false
               ;;Enable all CSS *functions*: rgb_fn, hsl_fn 
               :css_fn false
               :mode :background
               :always_update true}
      conf {:filetypes ["*"] :user_default_options default}]
  (require-then! :colorizer #($.setup conf)))
