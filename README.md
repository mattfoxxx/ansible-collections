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

gotcha: reference dependency roles in the collection with ansible.legacy.module_name in tasks.yml

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
git+file:///~/git/ansible-dotfiles/.git#mattfoxxx/dotfiles,e8096b720611086bf2020f75879d716728b17cec
```

## dotfiles collection

### mattfoxxx.dotfiles

manages the dotfiles on my machines

### mattfoxxx.dotfiles.tmux

var `tmux_config` to override with custom configuration in playbook pathing, eg. `playbooks/files/my_tmux.conf` and specifying a playbook variable:

```yaml
vars:
  tmux_config: "my_tmux.conf"
```

## TODO

## Bugs / Improvements
- remove stupid users array and replace with simple variable
- conflicting writes to .zshrc
- Document testing configuration
- write more tests!!

## Missing Packages
- weechat and dependencies
- kubectl
- lynx
- custom scripts in `~/.local/bin` - change `$PATH` accordingly
- alacritty

## Configuration Hints
### fonts-firacode
```bash
mkdir -p ~/.local/share/fonts
```
```bash
cd ~/.local/share/fonts && curl -fLo "Fira Code Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
```
```bash
cd ~/.local/share/fonts && curl -fLo "Fira Code Regular Nerd Font Complete.ttf"  https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf?raw=true
```
`fc-cache -rv` will rebuild font cache. `fc-list` lets you check the correct names for the font. `FiraCode Nerd Font` and `FiraCode Nerd Font Mono` for the just downloaded font.

#### Setup for chromebooks
In the terminal:
1. Use the keyboard shortcut <kbd>CTRL</kbd> + <kbd>SHIFT</kbd> + <kbd>J</kbd> to open the JavaScript Console.
2. Copy & paste the following 3 commands:
```
term_.prefs_.set('font-family', '"Fira Code", Cousine, "Roboto Mono", "Source Code Pro", monospace');
term_.prefs_.set('user-css-text', "x-row { font-feature-settings: 'liga', 'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07'; text-rendering: optimizeLegibility; }")
term_.prefs_.set('user-css', 'https://cdn.jsdelivr.net/npm/firacode@latest/distr/fira_code.min.css')
```

Note: The values for font-feature-settings can be tuned to your preference. For more details see the documentation at [stylistic sets](./How-to-enable-stylistic-sets)

chrome os setup from https://github.com/tonsky/FiraCode/wiki/ChromeOS-Terminal

