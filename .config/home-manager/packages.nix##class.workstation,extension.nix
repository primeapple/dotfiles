{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mvnd
    toot
    # currently broken, see https://github.com/NixOS/nixpkgs/issues/511900
    # yt-dlp
  ];
}
