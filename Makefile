build-darwin:
	@nix build .#darwinConfigurations.juni-mbp.system

switch-darwin:
	@./result/sw/bin/darwin-rebuild switch --flake .

deploy-nixos:
	# change this to use a nix dev shell instead
	@nix run github:nixos/nixpkgs/23.11#deploy-rs .#duch
