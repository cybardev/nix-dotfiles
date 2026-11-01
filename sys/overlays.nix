{ inputs, ... }:
with inputs;
[
  cypkgs.overlays.default
  # ccache 4.14.2 adds Linux-only elfutils to its check inputs on all Unix
  # platforms. Disable its test suite on Darwin (where it could never have run)
  # so the package evaluates and builds on aarch64-darwin.
  (
    final: prev:
    prev.lib.optionalAttrs prev.stdenv.hostPlatform.isDarwin {
      ccache = prev.ccache.overrideAttrs (_: {
        doCheck = false;
      });
    }
  )
]
