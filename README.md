# My ansible collections

## Installation example

### install required collection from requirements file.

```bash
ansible-galaxy collection install -r requirements.yml
```

### cd to `playbook/` and run playbook, optionally add tags. Remove `-C` to persist changes.

```bash
ansible-playbook --connection=local -l localhost -i localhost, -DC dotfiles.yml
```

```bash
ansible-playbook --connection=local -l localhost -i localhost, -DC -tags tmux dotfiles.yml
```

## Development hints

### Remove collection locally

```bash
rm -rf ~/.ansible/collections/ansible_collections/mattfoxxx
```

### Install collection from local commit

```bash
ansible-galaxy collection install git+file:///~/git/ansible-collections/.git#mattfoxxx/dotfiles
```

### Install older commit by adding a tag or commit hash

```bash
ansible-galaxy collection install \
git+file:///home/matze/git/ansible-dotfiles/.git#mattfoxxx/dotfiles,e8096b720611086bf2020f75879d716728b17cec
```

## dotfiles collection

### mattfoxxx.dotfiles

manages the dotfiles on my machines

### mattfoxxx.dotfiles.tmux

var `tmux_conf` to override with custom configuration in playbook pathing, eg. `playbooks/files/my_tmux.conf` and specifying a playbook variable:

```yaml
vars:
  tmux_conf: "my_tmux.conf"
```