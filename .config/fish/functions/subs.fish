function subbing
    set i 1
    for mkv in (ls *.mkv | sort)
        set base (path basename -E $mkv)
        set srt "$base.srt"
        if test -f "$srt"
            set out (printf "%02d.mkv" $i)
            echo "Muxing $mkv + $srt -> $out"
            mkvmerge -o "$out" "$mkv" "$srt"
            set i (math $i + 1)
        else
            echo "Warning: No .srt found for $mkv"
        end
    end
end

