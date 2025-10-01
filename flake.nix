{
  description = "Boilerplate for java development";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        outName = "out";
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
          pname = "${outName}";
          version = "1.0";

          src = ./.;


          buildInputs = [ pkgs.jdk24 ];


          buildPhase = ''
            mkdir -p out
            javac -d out src/Main.java
          '';

          installPhase = ''
            mkdir -p $out/bin
            echo "#!/bin/sh" > $out/bin/${outName}
            echo "${pkgs.jdk24}/bin/java -cp $out/share/classes Main" >> $out/bin/${outName}
            chmod +x $out/bin/out

            mkdir -p $out/share/classes

            cp -r out/* $out/share/classes
          '';
        };
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/${outName}";
        };
      });
}
