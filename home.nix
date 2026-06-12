{ pkgs, ... }:

{
  # Home Managerが管理するユーザー名とホームディレクトリのパス設定
  home.username = "mimoko";
  home.homeDirectory = "/Users/mimoko";

  # この値は、設定の互換性を保つHome Managerのリリースを指定します。
  # 新しいHome Managerで互換性のない変更が導入された際の設定破損を防ぎます。
  # この値を変更せずにHome Managerをアップデートしても問題ありません。
  home.stateVersion = "26.05";

  # home.packagesオプションを使用して、ユーザー環境にパッケージをインストールできます。
  home.packages = [
    pkgs.htop
    pkgs.ripgrep
    pkgs.fd
    pkgs.tmux
  ];

  # Home Manager自身を管理・インストールできるようにします。
  programs.home-manager.enable = true;

  # Home Managerによって管理されるGitの設定例
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "mimoko";
        email = "exit.regret@gmail.com";
      };
    };
  };
}
