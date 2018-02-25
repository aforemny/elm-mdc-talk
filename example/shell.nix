{ pkgs ? import <nixpkgs> {} }:

rec {
    elm-make = pkgs.elmPackages.elm-make;
    elm-package = pkgs.elmPackages.elm-package;
    elm-repl = pkgs.elmPackages.elm-repl;
    elm-reactor = pkgs.elmPackages.elm-reactor;

    example = pkgs.stdenv.mkDerivation {
        name = "example";
        buildInputs =
            [ elm-make elm-package elm-repl elm-reactor
            ];
    };
}
