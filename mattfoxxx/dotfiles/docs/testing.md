# Testing ansible roles/playbooks with pytest, testkitchen, testinfra and docker/vagrant

Tests are run from the `roles/testkitchen` directory which also contains the role to install testkitchen

## Links
- https://testinfra.readthedocs.io/


## Setup
* python packages
* create venv
* activate with `. ~/.venvs/testing/bin/activate`
* install packages `pip3 install paramiko pytest pytest-xdist testinfra\[ansible,salt\]`

## Testing with docker




## Testing with vagrant 
* vagrant test command
`pytest --host='paramiko://vagrant@127.0.0.1:2222?ssh_identity_file=/home/matze/git/ansible-collections/mattfoxxx/dotfiles/roles/testkitchen/tests/.kitchen/kitchen-vagrant/default-archlinux-archlinux/.vagrant/machines/default/virtualbox/private_key' test/integration/${KITCHEN_SUITE} `