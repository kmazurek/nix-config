build-darwin:
	@nix build .#darwinConfigurations.juni-mbp.system

switch-darwin:
	@./result/sw/bin/darwin-rebuild switch --flake .
