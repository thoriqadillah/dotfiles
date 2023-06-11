#!/bin/bash

echo -e "\033[1;32mInstalling Curl if not exist\033[0m"
rpm -qa | grep zsh || dnf install curl -y
echo -e "\033[1;32mDone!\n\033[0m"

echo -e "\033[1;32mInstalling ZSH if not exist\033[0m"
rpm -qa | grep zsh || dnf install zsh -y
echo -e "\033[1;32mDone!\n\033[0m"

echo -e "\033[1;32mChange shell to zsh as default\033[0m"
chsh -s $(which zsh)
echo -e "\033[1;32mDone!\n\033[0m"

echo -e "\033[1;32mInstalling Oh My ZSH if not exist\033[0m"
DIR=$HOME/.oh-my-zsh
SIZE=$(du -s $DIR | awk '{print $1}')
if [ $SIZE -gt 0 ]; then
  echo -e "\033[1;33mOh my zsh probably is already installed. Continue...\033[0m"
else
  echo -e "\033[1;32mInstalling oh my zsh. Don't forget to exit the zsh after installing zsh to continue this script.\033[0m"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo -e "\033[1;32mDone!\n\033[0m"
fi

echo -e "\033[1;32mAdding ZSH syntax highlighting\033[0m"
DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ -d "$DIR" ]; then
  echo -e "\033[1;33mZSH syntax highlighting is already installed. Continue...\033[0m"
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo -e "\033[1;32mDone!\n\033[0m"
fi

echo -e "\033[1;32mAdding ZSH auto suggestions\033[0m"
DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ -d "$DIR" ]; then
  echo -e "\033[1;33mZSH auto suggestions is already installed. Continue...\033[0m"
else
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo -e "\033[1;32mDone!\n\033[0m"
fi

echo -e "\033[1;32mInstalling tmux if not exist\033[0m"
rpm -qa | grep tmux || dnf install tmux -y
echo -e "\033[1;32mDone!\n\033[0m"

echo -e "\033[1;32mAdding tmux plugin manager\033[0m"
DIR=$HOME/.tmux/plugins/tpm
if [ -d "$DIR" ]; then
  echo -e "\033[1;33mTmux plugin manager is already installed. Continue...\033[0m"
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo -e "\033[1;32mDone!\n\033[0m"
fi

echo -e "\033[1;32mInstalling zoxide if not exist\033[0m"
rpm -qa | grep zoxide || dnf install zoxide -y
echo -e "\033[1;32mDone!\n\033[0m"

echo -e "\033[1;32m===== Setup development environtment =====\033[0m"
echo -e "\033[1;32mInstalling Go if not exist\033[0m"
rpm -qa | grep zsh || dnf install golang -y
DIR=$HOME/.tmux/plugins/tpm
if [ ! -d "$DIR" ]; then
  mkdir -p $HOME/go
fi
echo -e "\033[1;32mDone!\n\033[0m"

echo -e "\033[1;32mInstalling NVM and Node LTS if not exist\033[0m"
DIR=$HOME/.nvm
SIZE=$(du -s $DIR | awk '{print $1}')
if [ $SIZE -gt 0 ]; then
  echo -e "\033[1;33mNVM probably is already installed. Continue...\033[0m"
else
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash  
  source $HOME/.zshrc
  nvm install lts/*
  echo -e "\033[1;32mDone!\n\033[0m"
fi

echo -e "\033[1;32mInstallation finished!\033[0m"