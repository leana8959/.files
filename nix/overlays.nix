inputs: system:
let
  extend =
    ps:
    (inputs.nixpkgs.lib.trivial.pipe ps [
      (map (name: { ${name} = inputs.${name}.packages.${system}.default; }))
      (builtins.foldl' (x: y: x // y) { })
    ]);
in
extend [
  # stuff
  "wired"
  "agenix"
  "llama-cpp"
  "nix-visualize"
  "nix-inspect"
  # My packages
  "audio-lint"
  "hbrainfuck"
  "prop-solveur"
]
