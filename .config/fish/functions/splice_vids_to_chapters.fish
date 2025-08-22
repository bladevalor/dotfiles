function prepend_echo
    set_color $argv[1]
    echo -n $argv[2]
    set_color normal
    echo $argv[3..-1]
end

function seconds_to_hms
    set -l total_seconds $argv[1]
    set -l h (math -s 0 "$total_seconds / 3600")
    set -l remaining_seconds (math -s 0 "$total_seconds % 3600")
    set -l m (math -s 0 "$remaining_seconds / 60")
    set -l s (math -s 0 "$remaining_seconds % 60")
    echo "$h:$m:$s"
end

function sanitize_title
    set -l title $argv[1]

    # Remove characters not allowed or problematic in filenames:
    # These include: / \ ? % * : | " < > .
    set title (string replace -r '[\/\\\?\%\*\:\|\"<>\r\n\t]' '' $title)

    echo $title
end

function splice_vids_to_chapters
    set vidfile $argv

    if test ! -f "$vidfile"
        prepend_echo ff0000 "no such file:   " "$vidfile"
        return 1
    end

    set extension $(path extension "$vidfile")
    if test ! "$extension" = ".mkv"; and test ! "$extension" = ".mp4"
        echo 'only "mkv" and "mp4" files allowed'
        return 1
    end

    set chapters_exist (ffprobe -v 0 -show_chapters $vidfile)
    if test -z "$chapters_exist"
        prepend_echo ff0000 "no chapters found in file: " "$vidfile"
        return 0
    end

    set folder (path basename -E $vidfile)
    if test ! -d "$folder"
        mkdir "$folder"
    else
        prepend_echo ff0000 "no such folder:   " "$folder"
        return 1
    end

    set iter 1

    ffprobe -v 0 -i "$vidfile" -show_chapters -of compact=nokey=1 |
        awk -F '|' '{split($5,a, "."); split($7,b,"."); print a[1]"|"b[1]"|"$8}' |
        while IFS="|" read start_time end_time chapter_title
            set -l clean_title (sanitize_title $chapter_title)
            set -l index (printf "%02d" $iter)
            prepend_echo 00ff00 "CREATING: " "$index. $clean_title"
            ffmpeg -i "$vidfile" \
                -v 0 \
                -ss (seconds_to_hms "$start_time") \
                -to (seconds_to_hms "$end_time") \
                -c copy \
                "$folder/$index. $clean_title$extension" &
            set iter (math $iter + 1)
        end
    set iter 1

end
