{
  rustPlatform,
  fetchFromGitHub,
  fetchpatch,
}:

rustPlatform.buildRustPackage {
  pname = "typst-mutilate";
  version = "0.0";

  src = fetchFromGitHub {
    owner = "frozolotl";
    repo = "typst-mutilate";
    rev = "9bf5ed1f8a2f91055a91077f0a8545ff1f229933";
    hash = "sha256-r4fkFv1np8xhff3m8yev1rU1vfKRz8zQMIKIc+fOjew=";
  };

  cargoSha256 = "sha256-QEOXPf/k+fCMNQxKGsW3FDsgH5XXUKob0XOef3DiB0s=";

  patches = [
    (fetchpatch {
      name = "raw-block-fix";
      url = "https://github.com/frozolotl/typst-mutilate/pull/2/commits/223bc31abb2d5fef4e743a1582bb126a2ef47a45.patch";
      hash = "sha256-+6DMQo4cjVASgkX4gcYrEkwQ/uxttV/61fDnXBqbNcg=";
    })
  ];
}
