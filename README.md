# 🏯🎋🎍🌸 saruDpol's dotfiles 🐒🥋🦧🦍

![terminal](./images/terminal.png)

![nvim](./images/nvim.png)

Final guidelines to install the configuration anywhere! :)

---

## 1. Install WSL and Ubuntu

1. Open PowerShell as Administrator.
2. Enable WSL:

```powershell
wsl --install
```

3. Set default version to WSL 2:

```powershell
wsl --set-default-version 2
```

4. Install Ubuntu:

```powershell
wsl --install -d Ubuntu
```

5. Launch Ubuntu from the Start menu and create your UNIX user.

---

## 2. Install WezTerm (Windows Terminal Emulator)

1. Go to [WezTerm releases](https://wezfurlong.org/wezterm/) and download the latest Windows installer.
2. Install WezTerm.
3. Now we'll configure the rest through the windows Ubuntu terminal, and after everything is set, go back to the wez configuration.

---

## 3. Open Windows Ubuntu Terminal and Update

```bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl unzip wget git ripgrep fd-find tmux build-essential libssl-dev libffi-dev

```

---

## 4. Essential Tools to Install

- Zsh
- Oh My Zsh
- Starship Prompt
- Neovim
- Ripgrep
- Fuzzy Finder (fd)
- Zoxide
- GitHub CLI
- tmux
- Python (python3, pip, venv, pynvim)
- UV
- Node.js + npm
- Yarn
- React Native CLI
- Nerd Fonts (BlexMono)
- Optional: nvm for managing Node versions

### 4.1 Install Fonts

1. Download Nerd Font (BlexMono) from [Nerd Fonts](https://www.nerdfonts.com/font-downloads).
2. Install the font in Windows.

### 4.2 Install dependencies

To go blazingly fast...

```bash

# -------------------------------
# 1️⃣ Oh My Zsh & Plugins
# -------------------------------
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Switch default shell to Zsh
chsh -s $(which zsh)

# -------------------------------
# 2️⃣ eza
# -------------------------------
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# -------------------------------
# 3️⃣ Latest Neovim from GitHub
# -------------------------------
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim

# Add Neovim to PATH
echo 'export PATH="/opt/nvim/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# -------------------------------
# 4️⃣ Starship Prompt
# -------------------------------
curl -fsSL https://starship.rs/install.sh | bash

# -------------------------------
# 5️⃣ Zoxide
# -------------------------------
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# -------------------------------
# 6️⃣ Python & pynvim (system)
# -------------------------------
# Make sure system Python3 is installed
sudo apt update
sudo apt install -y python3 python3-pip python3-venv python3-pynvim build-essential libssl-dev libffi-dev

# -------------------------------
# 7️⃣ uv (Python version manager)
# -------------------------------
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# -------------------------------
# 8️⃣ Node.js via NVM
# -------------------------------
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts

# -------------------------------
# 9️⃣ Yarn & React Native CLI
# -------------------------------
npm install --global yarn
npm install --global react-native-cli

```

---

## 5. Clone Your Config Repo

```bash
cd ~
git clone https://github.com/saruDpol/dotfiles_wsl
```

Move WezTerm config to Windows home:

```bash
cp ~/dotfiles_wsl/dotfiles/.wezterm.lua /mnt/c/Users/<YourUser>/.wezterm.lua
```

---

## 6. Link Config Files in Ubuntu

```bash
mv ~/dotfiles_wsl/dotfiles/.zshrc ~/.zshrc
mv ~/dotfiles_wsl/dotfiles/.bashrc ~/.bashrc
mv ~/dotfiles_wsl/dotfiles/.bash_profile ~/.bash_profile
mv ~/dotfiles_wsl/starship.toml ~/.config/starship.toml
mv ~/dotfiles_wsl/nvim ~/.config/
mv ~/dotfiles_wsl/eza ~/.config/
rm -rf dotfiles_wsl
```

---

## 7. Setup Git Authentication

```bash
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
ssh-keygen -t ed25519 -C "youremail@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub  # Add to GitHub/GitLab
```

---

## 8. Try WEZ | ✅🛫

Open WezTerm, it should launch Ubuntu in Zsh with Starship prompt. Test basic commands:

```bash
cl
nvim
git status
lt
```

---
