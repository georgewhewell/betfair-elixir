with import <nixpkgs> {}; {
 exeEnv = stdenv.mkDerivation {
   name = "exs";
   buildInputs = [
    stdenv
    elixir
  ];
 };
}
