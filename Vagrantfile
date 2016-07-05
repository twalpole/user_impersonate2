# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'parallels/ubuntu-14.04'

  config.vm.provision :shell, privileged: false, inline: <<-SHELL
    echo 'cd /vagrant' >> /home/vagrant/.bashrc

    sudo apt-get update -y
    sudo apt-get install -y \
      git \
      libsqlite3-dev \
      sqlite3

    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    ~/.rbenv/bin/rbenv init >> ~/.bashrc 2>&1

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    ~/.rbenv/bin/rbenv install 2.1.10
  SHELL
end
