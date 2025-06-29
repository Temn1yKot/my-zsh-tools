: "
The project was created on June 29, 2025
for my projects, but I decided to publish it on github, use it (if you need it of course)
"

del() {
  if [[ "$1" == "--help" ]]; then
    echo "Usage for delete file/directory: del <your file or directory>\nUsage for delete file: del -f <path to the file>\nUsage for delete directory: del -d <path to the directory>\nUsage -s at the end to the confirm deleting(without -s you will be asked if you confirm the deletion)"
  else
    local sure="no"
    if [[ "$3" == "-s" || ( "$1" != "-d" && "$1" != "-f" && "$2" == "-s" ) ]]; then
      sure="yes"
    fi

    confirm_delete() {
      echo -n "You sure you want to delete \"$1\"? (y/n): "
      read confirm
      if [[ "$confirm" == "y" ]]; then
        return 0
      else
        echo "Aborted"
        return 1
      fi
    }

    if [[ "$1" == "-d" && -n "$2" ]]; then
      if [[ -d "$2" ]]; then
        if [[ "$sure" == "yes" ]] || confirm_delete "directory $2"; then
          rm -r "$2"
          echo "Deleted directory: $2"
        fi
      else
        echo "del: Directory \"$2\" not found"
      fi

    elif [[ "$1" == "-f" && -n "$2" ]]; then
      if [[ -f "$2" ]]; then
        if [[ "$sure" == "yes" ]] || confirm_delete "file $2"; then
          rm "$2"
          echo "Deleted file: $2"
        fi
      else
        echo "del: File \"$2\" not found"
      fi

    else
      if [[ -d "$1" || -f "$1" ]]; then
        if [[ "$sure" == "yes" ]] || confirm_delete "$1"; then
          rm -r "$1"
          echo "Deleted directory or file: $1"
        fi
      else
        echo "del: Directory or file \"$1\" not found"
      fi
    fi
  fi
}


run() {
  if [[ $1 == "--help" ]]; then
    echo "Usage: \"run <file>\", you can only run:\n.py(only with installed python3), .cpp(only with installed g++), .c(only with installed gcc), .cs(only with installed mono),\n.js(only with installed node.js), .sh(zsh is the default, but you can specify the 2nd argument as a console in which you can run it), .java(only with installed java interpreter(NOT COMPILER!)), .lua(with installed lua interpreter), .zsh"
    return 0
  elif [ ! -f "$1" ]; then
    echo "File \"$1\" not found"
    return 1
  fi

  filename="$1"
  ext="${filename##*.}"
  base="${filename%.*}"
  if [[ "$2" && "$ext" != "sh" && "$ext" != "zsh" && "$ext" != "bash" ]]; then
    if [[ "$2" == "python3" || "$2" == "python" || "$2" == "lua" || "$2" == "node" || "$2" == "java" || "$2" == "ruby" ]]; then
      "$2" "$filename"
    elif [[ "$2" == "cpp" || "$2" == "C++" || "$2" == "CPP" ]]; then
      out="$base.out"
      if g++ "$filename" -o "$out"; then
        ./"$out"
        rm "$out"
      else
        echo "❌ Compilation failed"
        return 1
      fi
    elif [[ "$2" == "c" || "$2" == "C" ]]; then
      out="$base.out"
      if gcc "$filename" -o "$out"; then
        ./"$out"
        rm "$out"
      else
        echo "❌ Compilation failed"
        return 1
      fi
    elif [[ "$2" = "cs" || "$2" == "C#" || "$2" == "c#" || "$2" == "CS" ]]; then
      if mcs "$filename"; then
        mono "$base.exe"
        rm "$base.exe"
      else
        echo "❌ Compilation failed"
        return 1
      fi
    elif [[ "$2" == "go" || "$2" == "GO" || "$2" == "Go" ]]; then
      go run "$filename"
    elif [[ "$2" == "compile_go" || "$2" == "compile_GO" || "$2" == "compile_Go" ]]; then
      if go build -o "$out" "$filename"; then
        ./"$out"
        rm "$out"
      else
        echo "❌ Compilation failed"
        return 1
      fi
    else
      echo "Unknown executor \"$2\""
    fi
  else
    case "$ext" in
    py)
      python3 "$filename"
      ;;
    cpp)
      out="$base.out"
      if g++ "$filename" -o "$out"; then
        ./"$out"
        rm "$out"
      else
        echo "❌ Compilation failed"
        return 1
      fi
      ;;
    c)
      out="$base.out"
      if gcc "$filename" -o "$out"; then
        ./"$out"
        rm "$out"
      else
        echo "❌ Compilation failed"
        return 1
      fi
      ;;
    cs)
      if mcs "$filename"; then
        mono "$base.exe"
        rm "$base.exe"
      else
        echo "❌ Compilation failed"
        return 1
      fi
      ;;
    js)
      node "$filename"
      ;;
    go)
      go run "$filename"
      : '
      but you can replace it with this if you need compilation:
      out="$base.out"
      if go build -o "$out" "$filename"; then
        ./"$out"
        rm "$out"
      else
        echo "❌ Compilation failed"
        return 1
      fi
      '
      ;;
    rs)
      out="$base.out"
      if rustc "$filename" -o "$out"; then
        ./"$out"
        rm "$out"
      else
        echo "❌ Compilation failed"
        return 1
      fi
    ;;
    rb)
      ruby "$filename"
      ;;
    sh)
      if [[ ! "$2" ]]; then
        zsh "$filename"
      elif [[ -f "/bin/$2" ]]; then
        $2 "$filename"
      else
        echo "Unknown console: $2"
        return 1
      fi
      ;;
    zsh)
      zsh "$filename"
      ;;
    java)
      java "$filename"
      ;;
    lua)
      lua "$filename"
      ;;
    *)
      if [ -x "$filename" ]; then
        ./"$filename"
      else
        echo "Impossible to run .$ext files"
        return 1
      fi
      ;;
    esac
  fi
}