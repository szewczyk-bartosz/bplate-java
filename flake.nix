{
  description = "Boilerplate for java development";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            jdk24
            maven
          ];

        shellHook = ''
          echo "=== NOW RUNNING JAVA DIRENV ==="
        '';

        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "generic-java-app";
          version = "1.0";

          src = ./.;


          buildInputs = [ pkgs.jdk24 ];


          buildPhase = ''
            mkdir -p out
            javac -d out src/Main.java
          '';

          installPhase = ''
            mkdir -p $out/bin
            echo "#!/bin/sh" > $out/bin/generic-java-app
            echo "${pkgs.jdk24}/bin/java -cp $out/share/classes Main" >> $out/bin/my-java-app
            chmod +x $out/bin/out

            mkdir -p $out/share/classes

            cp -r out/* $out/share/classes
          '';
        };
      });
}
