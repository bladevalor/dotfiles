function vidtitle
   if test (count $argv) -ne 1
      echo "usage: vidtitle <mkv|mp4>"
      return 1
   else if not string match -qr "mkv|mp4" $argv[1]
      echo '"mkv" or "mp4" extensions only'
      return 1
   end

   for file in (fd -e $argv[1])
      echo $file
      if test $argv[1] = "mkv"
         mkvpropedit $file -e info -s title=(basename $file)
      else if test $argv[1] = "mp4"
         exiftool -All= "$file"
         rm -rf "$file"_original
      end
   end
end
