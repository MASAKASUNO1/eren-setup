# Post Setup

Run these tasks after `./setup.sh` finishes.

## Login

- `gh auth login`
- `vercel login`
- `bw login` if you use the Bitwarden CLI separately
- Sign in to Slack
- Sign in to Bitwarden
- Sign in to Google in Chrome
- `sudo tailscale up`
- `gogcli auth` if you installed optional personal tools

## First-Run Checks

- Launch Chrome and confirm sync / profile settings
- Launch VS Code and install any personal extensions
- Launch Ghostty and confirm shell startup works
- Launch Stats and grant permissions if prompted
- Run `agent-browser install` again if the first install was skipped or incomplete

## Verify

- `brew --version`
- `git --version`
- `gh --version`
- `mise --version`
- `node --version`
- `npm --version`
- `codex --version || true`
- `vercel --version`
- `python3 --version`

## Recommended Optional Apps

If you skipped GUI apps during setup:

- `open -a "Google Chrome"`
- `open -a "Visual Studio Code"`
- `open -a "Ghostty"`
- `open -a "Slack"`
- `open -a "Bitwarden"`
- `open -a "Stats"`
