{ pkgs, ... }:

{
  # システム全体にインストールするパッケージの一覧
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
  ];

  # Nixデーモンサービスを有効化
  nix.enable = true;

  # このシステムでFlakesを使用するために必要な設定
  nix.settings.experimental-features = "nix-command flakes";

  # nix-darwinの環境をロードするための/etc/zshrcを作成（macOSのデフォルトシェル）
  programs.zsh.enable = true;

  # 後方互換性のための設定。変更する前にchangelogを確認してください。
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # nix-darwinが認識できるようにユーザーを定義
  users.users.mimoko = {
    name = "mimoko";
    home = "/Users/mimoko";
  };
}
