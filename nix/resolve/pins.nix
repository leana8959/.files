final: _:
let
  inherit (final) system;
in
{
  # stackage LTS 22.22 / ghc965 (May 19 2024) / hls 2.8.0.0
  ghc-pin = import (final.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "1faadcf5147b9789aa05bdb85b35061b642500a4";
    hash = "sha256-KTUFPrsI0YW/S8ZcbIAXnWI2BiGm/IGqNAFco88lBYU=";
  }) { inherit system; };

  alt-ergo-pin =
    import
      (final.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "1b95daa381fa4a0963217a5d386433c20008208a";
        hash = "sha256-vwEtkxIEQjymeTk89Ty1MGfRVSWL1/3j1wt5xB5ua88=";
      })
      {
        inherit system;
        config.allowUnfree = true;
      };

  neovim-pin = import (final.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "6132b0f6e344ce2fe34fc051b72fb46e34f668e0";
    hash = "sha256-7R2ZvOnvd9h8fDd65p0JnB7wXfUvreox3xFdYWd1BnY=";
  }) { inherit system; };

  nur =
    import
      (final.fetchFromGitHub {
        owner = "nix-community";
        repo = "nur";
        rev = "9bf273a054250a990e3751cc7ae280c6ff5b4220";
        hash = "sha256-2Cr9RYM276lo1a9g3QaflZy7/TxtDXpAhxWF3WsEPhQ=";
      })
      {
        nurpkgs = final;
        pkgs = final;
      };
}
