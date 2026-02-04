function ffprobe
    podman run --rm -it --entrypoint ffprobe -v $(pwd):/data -w /data linuxserver/ffmpeg:version-8.0-cli $argv
end
