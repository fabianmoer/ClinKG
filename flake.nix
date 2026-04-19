{
  # one flake for all right now
  description = "ClinKG development flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonPackages = pkgs.python311Packages;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.python313
            pythonPackages.fastapi
            pythonPackages.uvicorn
            pythonPackages.httpx
            # Add other dependencies here, e.g.,
            # pythonPackages.sqlalchemy
            # pythonPackages.pydantic
          ];

          shellHook = ''
            echo "--- FastAPI Development Environment ---"
            echo "Python version: $(python --version)"
            echo "Run your app with: uvicorn main:app --reload"
          '';
        };
      });
}
