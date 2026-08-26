{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    hyperfine
    jq
    llama-cpp
    mvnd
    toot
    yq-go
    yt-dlp
    # Build currently failing on macos
    # zf
  ];
}
