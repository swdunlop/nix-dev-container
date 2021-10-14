let 
  overlay = import nix/overlay.nix;
  nixpkgs = import nix/nixpkgs.nix;
  pkgs = import nixpkgs { overlays = [ overlay ]; }; 
in pkgs.mkShell {
  name = "shell";
  buildInputs = with pkgs; [
    git
    go
  ];
}