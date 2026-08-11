# EasyBar Homebrew Tap

The official Homebrew tap for EasyBar products and their helper services.

## Requirements

- macOS 14 Sonoma or newer
- [Homebrew](https://brew.sh/)

## Installation

Install EasyBar:

```bash
brew tap easybar-app/tap
brew install --cask easybar-app/tap/easybar
open -a EasyBar
```

Install EasyBar Native:

```bash
brew tap easybar-app/tap
brew install --cask easybar-app/tap/easybar-native
open -a "EasyBar Native"
```

EasyBar's calendar and network helper agents are installed as cask dependencies and managed through
Homebrew Services. EasyBar Native does not install those agents.

## Upgrade

```bash
brew update
brew upgrade --cask easybar-app/tap/easybar
brew upgrade --cask easybar-app/tap/easybar-native
```

## Uninstall

```bash
brew uninstall --cask easybar-app/tap/easybar
brew uninstall --cask easybar-app/tap/easybar-native
```

See the [EasyBar installation guide](https://easybar.dev/products/easybar/installation/) and
[EasyBar Native installation guide](https://easybar.dev/products/easybar-native/installation/) for
verification, service management, upgrades, and complete removal.

## License

The tap is licensed under the [Apache License 2.0](./LICENSE). Distributed applications and helper
agents retain the licenses declared by their upstream projects.
