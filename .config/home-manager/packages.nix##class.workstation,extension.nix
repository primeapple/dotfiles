{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    hyperfine
    llama-cpp
    mise
    pi-coding-agent
    toot
    yt-dlp
    # Build currently failing on macos
    # zf
  ];
}
