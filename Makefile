# 対象システムのホスト名
HOSTNAME = manaita

.PHONY: switch build bootstrap gc-clean

# デフォルトのターゲット: 設定を適用する
switch:
	git add -A
	sudo darwin-rebuild switch --flake .#$(HOSTNAME)

# 設定をビルドするのみ（構文や型のチェックに有効）
build:
	git add -A
	darwin-rebuild build --flake .#$(HOSTNAME)

# 初回セットアップ用（リモートリポジトリのFlakeから直接darwin-rebuildを実行）
bootstrap:
	git add -A
	sudo nix --extra-experimental-features "nix-command flakes" run github:LnL7/nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake .#$(HOSTNAME)

# ディスク容量を空けるために古いNixストア世代をクリーンアップする
gc-clean:
	nix-collect-garbage -d
