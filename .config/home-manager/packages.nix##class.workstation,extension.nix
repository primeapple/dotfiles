{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    hyperfine
    llama-cpp
    mvnd
    pi-coding-agent
    toot
    yt-dlp
    # Build currently failing on macos
    # zf
  ];
}
