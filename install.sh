#!/bin/bash

function cfg_pip()
{
    if [ -e $HOME/.pip ]
    then
        cp -r ./pip/pip.conf $HOME/.pip
    else
        mkdir -p $HOME/.pip
        cp -r ./pip/pip.conf $HOME/.pip
    fi
    echo "pip configurated!"
}

function cfg_zshrc()
{
    # curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    cp -r ./zsh/zshrc $HOME/.zshrc
    source $HOME/.zshrc
    echo "zshrc configurated!"
}

function cfg_vimrc()
{
    cp -r ./vim/vimrc $HOME/.vimrc
    source $HOME/.vimrc
    echo "vimrc configurated!"
}

function cfg_tmux()
{
    cp -r ./tmux/tmux.conf $HOME/.tmux.conf
    echo "tmux.conf configurated!"
}

function lines()
{
    echo "====================================="
}

function main()
{
    lines
    echo "Configurating pip/zshrc/vimrc/tmux..."
    lines
    cfg_vimrc
    lines
    cfg_zshrc
    lines
    cfg_tmux
    lines
    cfg_pip
    lines
    echo "All done, enjoys!"
    lines
}

main
