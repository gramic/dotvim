These are my own vim customization files which are usually very personal.
However, you could take advantage of them if you will.

Here are some special notes and structure for this configuration.

0. Install git first. On Ubuntu machine use:
  sudo apt-get install git-core
1. Make link in your .vim directory to this .vimrc file. That way you can modify and push the changes back to this GitHub repository.

```sh
git clone https://github.com/gramic/dotvim.git ~/.config/nvim/plugged/dotvim && \
  ln -s ~/.config/nvim/plugged/dotvim/.vimrc ~/.config/nvim/init.vim && \
  ln -s ~/.config/nvim/plugged/dotvim/.tmux.conf ~/.tmux.conf
```
