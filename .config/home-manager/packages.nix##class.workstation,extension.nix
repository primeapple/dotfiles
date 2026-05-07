{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mvnd
    llama-cpp
    toot
    # currently broken, see https://github.com/NixOS/nixpkgs/issues/511900
    # yt-dlp
  ];
}
