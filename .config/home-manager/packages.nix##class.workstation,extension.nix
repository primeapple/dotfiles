{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    jwt-cli
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
