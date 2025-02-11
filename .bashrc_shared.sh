export PATH=$HOME/bin:$PATH

if ! test -f ~/.local/bin/getnf; then
	curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash -s -- --silent
fi

# Check if Hack font is installed using fc-list
if ! fc-list | grep -i "Hack Nerd Font Mono" > /dev/null; then
    echo "Hack font not found. Installing..."
    getnf -i "Hack Mono"
fi

# Fzf nvim opener
nf() {
    nvim $(fzf)
}

alias tnux=tmux-projects.sh
