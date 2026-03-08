# eren-setup

Public macOS bootstrap repo for a fresh machine.

The goal is not "100% unattended setup". The goal is a reliable split between:

- `setup.sh` for installable and repeatable steps
- `post-setup.md` for login, first-run, and verification tasks

## What This Repo Sets Up

- Homebrew
- Core CLI tools
- Common GUI apps
- `mise` and Node.js
- npm global packages for local AI / agent workflows
- Optional personal tools behind environment flags

## Files

- `setup.sh`: main bootstrap script
- `Brewfile`: core Homebrew formulae and casks
- `post-setup.md`: manual tasks after install

## Usage

```bash
git clone https://github.com/MASAKASUNO1/eren-setup.git
cd eren-setup
chmod +x setup.sh
./setup.sh
```

### Optional Flags

All options are controlled with environment variables.

```bash
INSTALL_GUI_APPS=0 ./setup.sh
INSTALL_PERSONAL_TOOLS=1 ./setup.sh
INSTALL_CLAUDE_CODE=1 ./setup.sh
INSTALL_AGENT_BROWSER=1 ./setup.sh
NODE_VERSION=24 ./setup.sh
```

## Default Behavior

By default the script:

- installs Homebrew if needed
- installs core CLI tools
- installs common GUI apps
- enables `mise`
- installs Node.js via `mise`
- installs npm globals: `@openai/codex`, `agent-browser`, `aiimage-cli`

It does not automatically complete:

- GitHub, Vercel, Bitwarden, Slack, Google sign-in
- `tailscale up`
- first-run GUI permissions and browser prompts

## Optional Personal Tools

Set `INSTALL_PERSONAL_TOOLS=1` to also install:

- `git-gtr`
- `gogcli`
- `codexbar`
- `nordvpn`

These are kept out of the default flow because they are more opinionated and less portable.

## Publish Notes

This repository is safe to keep public as long as you do not commit:

- API keys
- personal email addresses
- private URLs
- company-specific scripts
- machine-specific dotfiles with secrets

## Manual Follow-Up

After running the script, complete the checklist in [post-setup.md](post-setup.md).

## License

MIT
