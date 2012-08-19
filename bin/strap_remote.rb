#!/bin/bash
##
#

ssh $1 'sudo apt-get -y install git ruby1.9.1 rubygems'
ssh $1 'sudo gem install chef'
#scp ../chef/solo/cookbooks/base/files/default/id_rsa $1:~/.ssh/id_rsa
#ssh $1 'ssh -o StrictHostKeyChecking=no git@github.com'
#ssh $1 'git clone git@github.com:krogebry/misty.git'

ssh $1 'ln -s ~/misty/chef/solo/ ~/solo'

