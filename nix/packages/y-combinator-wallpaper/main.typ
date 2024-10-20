#set page(width: 3840pt, height: 2160pt, fill: black)
#set text(size: 2160pt / 16)
#set align(horizon + center)

#import "@preview/stonewall:0.1.0": lesbian
#let y_combinator = $lambda f. space
    (lambda x. space f space (x space x)) space
    (lambda x. space f space (x space x))$

#text(
  fill: gradient.linear(..lesbian),
  y_combinator,
)
