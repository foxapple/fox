#!/bin/sh

source $FOX_ROOT/common/variables.sh

function print_logo() {
  local color=${1:-$GREEN}
  printf "$color"
  cat <<-'EOF'
              _____  ______       ______________       _____   ______
             /     |/     /|     /     __      /|     |\    \ /    _/|
            /      '     / /    /     /|/     / /      \\    '   _/ _/
           /            / /    /     / /     / /        \\      / _/
          /            / /    /     / /     / /       __/       \/
         /     .      / /    /     /_/     / /    ___/    __.    \
        /_____/|_____/ /    /_____________/ /    /_______/ _|\____\
        |_____/|_____|/     |_____________|/     |_______|/  \____|

	EOF
	printf "$RESET"
}