#!/bin/bash

# Variables
GH_LINK="https://raw.githubusercontent.com/SrVariable/themedgehog/master/install.sh"
THEME_DIR="$HOME/.vim/colors"
NAME="themedgehog"

# Clone the git repository if it's not already cloned
if [[ "$(pwd)" != *"themedgehog" ]]; then
	git clone $GH_LINK_FILE $NAME
	cd $NAME
fi

# Create the directory if it doesn't exist
mkdir -p $THEME_DIR

# Copy the theme into the theme directory
cp $NAME.vim $THEME_DIR
