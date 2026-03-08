# Post Setup

`./setup.sh` 実行後に行う手動作業のチェックリストです。

## ログイン

- `gh auth login`
- `vercel login`
- Bitwarden CLI を使うなら `bw login`
- Slack にサインイン
- Bitwarden にサインイン
- Chrome で Google アカウントにサインイン
- `sudo tailscale up`
- 個人用ツールを入れた場合は `gogcli auth`

## 初回確認

- Chrome を起動して同期やプロフィール設定を確認する
- VS Code を起動して必要な拡張を入れる
- Ghostty を起動して shell の立ち上がりを確認する
- Stats を起動して権限ダイアログが出たら許可する
- `agent-browser install` をスキップした場合や不完全だった場合は再実行する

## 動作確認

- `brew --version`
- `git --version`
- `gh --version`
- `mise --version`
- `node --version`
- `npm --version`
- `codex --version || true`
- `vercel --version`
- `python3 --version`

## GUI アプリを後で開く場合

GUI アプリの導入をスキップした場合や、あとでまとめて確認したい場合:

- `open -a "Google Chrome"`
- `open -a "Visual Studio Code"`
- `open -a "Ghostty"`
- `open -a "Slack"`
- `open -a "Bitwarden"`
- `open -a "Stats"`
