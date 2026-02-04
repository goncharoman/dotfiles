function ffmpeg
    podman run --rm -it -v $(pwd):/data -w /data linuxserver/ffmpeg:version-8.0-cli $argv
end
