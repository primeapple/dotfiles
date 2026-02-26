{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mvnd
    toot
    yt-dlp
  ];
}
