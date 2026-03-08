# eren-setup

新しい macOS を素早く立ち上げるための、公開前提のセットアップリポジトリです。

目的は「完全自動化」ではなく、以下をきれいに分離することです。

- `setup.sh`: インストールや設定など、再実行しやすい処理
- `post-setup.md`: ログイン、初回起動、確認作業など人手が必要な処理

## このリポジトリでセットアップするもの

- Homebrew
- 基本的な CLI ツール
- よく使う GUI アプリ
- `mise` と Node.js
- AI / Agent 系の npm グローバルパッケージ
- 環境変数で有効化する任意の個人用ツール

## ファイル構成

- `setup.sh`: メインのセットアップスクリプト
- `Brewfile`: Homebrew で入れる formula / cask 一覧
- `post-setup.md`: セットアップ後の手動チェックリスト

## 使い方

```bash
git clone https://github.com/MASAKASUNO1/eren-setup.git
cd eren-setup
chmod +x setup.sh
./setup.sh
```

## オプション

各オプションは環境変数で切り替えます。

```bash
INSTALL_GUI_APPS=0 ./setup.sh
INSTALL_PERSONAL_TOOLS=1 ./setup.sh
INSTALL_CLAUDE_CODE=1 ./setup.sh
INSTALL_AGENT_BROWSER=1 ./setup.sh
NODE_VERSION=24 ./setup.sh
```

## デフォルト動作

何も指定しない場合、スクリプトは以下を実行します。

- Homebrew が未導入ならインストール
- 基本的な CLI ツールをインストール
- 一般的な GUI アプリをインストール
- `mise` を有効化
- `mise` 経由で Node.js をインストール
- npm グローバルパッケージ `@openai/codex`、`agent-browser`、`aiimage-cli` をインストール

一方で、以下は自動化の対象外です。

- GitHub、Vercel、Bitwarden、Slack、Google へのログイン
- `tailscale up`
- GUI アプリ初回起動時の許可ダイアログやブラウザ確認

## 個人用ツール

`INSTALL_PERSONAL_TOOLS=1` を付けると、以下も追加でインストールします。

- `git-gtr`
- `gogcli`
- `codexbar`
- `nordvpn`

これらは用途がやや個人依存なので、デフォルトでは外しています。

## Public 運用時の注意

このリポジトリは public で運用できますが、以下は commit しない前提です。

- API キー
- 個人メールアドレス
- private URL
- 会社固有のスクリプト
- 秘密情報を含む dotfiles やローカル設定

## セットアップ後の手作業

`./setup.sh` 実行後は [post-setup.md](post-setup.md) のチェックリストを進めてください。

## ライセンス

MIT
