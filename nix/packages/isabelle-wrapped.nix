{ isabelle, makeWrapper }:

isabelle.overrideAttrs (oa: {
  buildInputs = (oa.buildInputs or [ ]) ++ [ makeWrapper ];

  postFixup =
    (oa.postFixup or "")
    + ''
      wrapProgram $out/bin/isabelle \
        --set _JAVA_AWT_WM_NONREPARENTING 1
    '';
})
