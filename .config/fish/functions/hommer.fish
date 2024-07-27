function hommer
   set -l ent "/Desktop/Ent/"
   set -l vid "/Videos/"
   set -l ced "/Desktop/MUK/"
   set -l doc "/Documents/"
   set -l SUB_DIR ""
   set -l LOCAL "/home/einsteine"
   set -l REMOTE "homer-s@10.42.0.245:/home/homer-s"

   set -l arg_count (count $argv)
   if test $arg_count -lt 2 -o $arg_count -gt 3
      echo "usage: hommer <up|down> <dir> <[optional:] sub_dir>"
      return 1
   end

   if not string match -qr "down|up" $argv[1] 
      echo "usage: hommer <up|down> <dir> <[optional:] sub_dir>"
      return 1
   end

   if not string match -qr "ent|doc|vid|ced" $argv[2] 
      echo "Incorrect dir alias"
      return 1
   end

   if test (count $argv) -eq 3
      set SUB_DIR $argv[3]
   end

   switch $argv[2]
      case ent
         set DIR "$ent$SUB_DIR"
      case doc
         set DIR "$doc$SUB_DIR"
      case vid
         set DIR "$vid$SUB_DIR"
      case ced
         set DIR "$ced$SUB_DIR"
   end

   if test $argv[1] = "down"
      rsync -Phirt $REMOTE$DIR/ $LOCAL$DIR
   else if test $argv[1] = "up"
      rsync -Phirt $LOCAL$DIR/ $REMOTE$DIR
   end

end
