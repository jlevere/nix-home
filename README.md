# Home manager configureation

### Setup steps:
- [Have nix installed](https://github.com/DeterminateSystems/nix-installer)
- Clone repo
- `nix run .#homeConfigurations.admin.activationPackage`


### Warnings

There are some hardcoded things like, user names, key paths, git configs etc that you need to change if you want to use this config yourself.

If there is more than one key listed in your github profile `.keys` then I am pretty sure it will break. My profile has only one, so I haven't addressed that yet.

### Credits

Basically a clone of this super cool [nix-config](https://github.com/jm8/nix-config) 