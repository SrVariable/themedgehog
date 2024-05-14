#!/bin/bash

# Variables
GH_LINK="https://github.com/SrVariable/themedgehog.git"
THEME_DIR="$HOME/.vim/colors"
NAME="themedgehog"

# Clone the git repository if it's not already cloned
if [[ "$(pwd)" != *"themedgehog" ]]; then
	git clone $GH_LINK $NAME
	cd $NAME
fi

# Create the directory if it doesn't exist
mkdir -p $THEME_DIR

# Copy the theme into the theme directory
cp $NAME.vim $THEME_DIR
