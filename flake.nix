{
  description = "Darwin + Home Manager configuration flake";

  inputs = {
    # nixpkgsを最新のNixOS安定版リリース（26.05 "Yarara"）に固定
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # nix-darwinを対応する26.05リリースブランチに固定
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-managerを対応する26.05リリースブランチに固定
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }: {
    darwinConfigurations."manaita" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # Apple Silicon (M1/M2/M3/M4)用にaarch64-darwinを指定
      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mimoko = import ./home.nix;

          # 必要に応じてhome-managerモジュールに入力（inputs）を渡すための設定
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
