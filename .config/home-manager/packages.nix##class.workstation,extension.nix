{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mvnd
    llama-cpp
    toot
    yt-dlp
  ];
}
