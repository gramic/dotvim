#/bin/bash
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/gramic/dotvim.git ~/.vim/bundle/dotvim
ln -s ~/.vim/bundle/dotvim/.vimrc ~/.vimrc
ln -s ~/.vim/bundle/dotvim/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
