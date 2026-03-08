#!/usr/bin/env bash
set -euo pipefail

INSTALL_GUI_APPS="${INSTALL_GUI_APPS:-1}"
INSTALL_PERSONAL_TOOLS="${INSTALL_PERSONAL_TOOLS:-0}"
INSTALL_CLAUDE_CODE="${INSTALL_CLAUDE_CODE:-0}"
INSTALL_AGENT_BROWSER="${INSTALL_AGENT_BROWSER:-1}"
NODE_VERSION="${NODE_VERSION:-24}"

log() {
  printf '\n==> %s\n' "$1"
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

append_line_if_missing() {
  local line="$1"
  local file="$2"

  touch "$file"
  if ! grep -Fqx "$line" "$file"; then
    printf '%s\n' "$line" >> "$file"
  fi
}

install_homebrew() {
  if command_exists brew; then
    log "Homebrew already installed"
    return
  fi

  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

load_homebrew() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    printf 'Homebrew binary was not found after install.\n' >&2
    exit 1
  fi
}

install_brew_bundle() {
  local args=(bundle --file Brewfile)
  if [[ "$INSTALL_GUI_APPS" != "1" ]]; then
    args+=(--no-upgrade)
    HOMEBREW_BUNDLE_CASK_SKIP="ghostty,visual-studio-code,google-chrome,bitwarden,stats,slack" \
      brew "${args[@]}"
    return
  fi

  brew "${args[@]}"
}

install_personal_tools() {
  [[ "$INSTALL_PERSONAL_TOOLS" == "1" ]] || return

  log "Installing optional personal tools"

  if ! brew tap | grep -q '^coderabbitai/tap$'; then
    brew tap coderabbitai/tap
  fi

  if ! brew tap | grep -q '^steipete/tap$'; then
    brew tap steipete/tap
  fi

  brew install git-gtr gogcli
  brew install --cask codexbar nordvpn
}

setup_mise_node() {
  local zshrc="${HOME}/.zshrc"
  local mise_line='eval "$(mise activate zsh)"'

  log "Configuring mise"
  append_line_if_missing "$mise_line" "$zshrc"

  export PATH="${HOME}/.local/bin:${PATH}"
  eval "$(mise activate bash)"
  mise use -g "node@${NODE_VERSION}"
}

install_claude_code() {
  [[ "$INSTALL_CLAUDE_CODE" == "1" ]] || return

  log "Installing Claude Code"
  curl -fsSL https://claude.ai/install.sh | bash
}

install_npm_globals() {
  log "Installing npm global packages"
  npm install -g @openai/codex agent-browser aiimage-cli

  if [[ "$INSTALL_AGENT_BROWSER" == "1" ]]; then
    log "Installing browser runtime for agent-browser"
    agent-browser install || true
  fi
}

print_summary() {
  cat <<'EOF'

========================================
Setup completed.

Manual steps:
  1. gh auth login
  2. vercel login
  3. Open Slack and sign in
  4. Open Bitwarden and sign in
  5. Sign in to Google in Chrome
  6. sudo tailscale up
  7. Restart terminal or run: source ~/.zshrc

Optional manual steps:
  - bw login
  - gogcli auth
  - agent-browser first-run checks

Suggested app launches:
  open -a "Google Chrome"
  open -a "Visual Studio Code"
  open -a "Ghostty"
  open -a "Slack"
  open -a "Bitwarden"
  open -a "Stats"

Version checks:
  brew --version
  git --version
  gh --version
  mise --version
  node --version
  npm --version
  codex --version || true
  vercel --version

========================================
EOF
}

main() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    printf 'This script is for macOS only.\n' >&2
    exit 1
  fi

  log "Starting macOS bootstrap"
  install_homebrew
  load_homebrew

  log "Updating Homebrew"
  brew update

  log "Installing Brew packages"
  install_brew_bundle

  install_personal_tools
  setup_mise_node
  install_claude_code
  install_npm_globals
  print_summary
}

main "$@"
