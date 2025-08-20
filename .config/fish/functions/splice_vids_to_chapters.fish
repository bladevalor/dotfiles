function splice_vids_to_chapters
    set vidfile $argv

    if test ! -f "$vidfile"
        echo -e "This file does not exist:\n\t" "$vidfile"
        return 1
    end

    set extension $(path extension "$vidfile")
    if test ! "$extension" = ".mkv"; and test ! "$extension" = ".mp4"
        echo 'only "mkv" and "mp4" files allowed'
        return 1
    end

    set folder (path basename -E $vidfile)
    if test ! -d "$folder"
        mkdir "$folder"
    else
        echo -e "This folder already exists\n\t" "$folder"
        return 1
    end

    ffprobe -v 0 -i "$vidfile" -show_chapters -of compact=nokey=1 |
        cut -d "|" -f "5,7,8" |
        while IFS="|" read start_time end_time chapter_title
            set new_title (string replace -r '[Cc]hapter ' '' "$chapter_title")
            prepend_echo 00ff00 "CREATING: " "$new_title"

            ffmpeg -i "$vidfile" \
                -v 0 \
                -ss (seconds_to_hms "$start_time") \
                -to (seconds_to_hms "$end_time") \
                -c copy \
                "$folder/$new_title$extension"
            sleep 1
        end
end

function prepend_echo
    set_color $argv[1]
    echo -n $argv[2]
    set_color normal
    echo $argv[3..-1]
end

function seconds_to_hms
    set -l total_seconds $argv[1]
    set -l h (math "$total_seconds / 3600")
    set -l remaining_seconds (math "$total_seconds % 3600")
    set -l m (math "$remaining_seconds / 60")
    set -l s (math "$remaining_seconds % 60")
    echo "$h:$m:$s"
end
