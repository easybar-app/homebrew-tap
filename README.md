# easybar-app/homebrew-tap

Homebrew tap for `easybar` and `wifisnitch`.

## Install

```bash
brew tap easybar-app/tap
brew install easybar-app/tap/easybar
brew install easybar-app/tap/wifisnitch
```

## Services

```bash
brew services start easybar
brew services start wifisnitch
```

```bash
brew services restart easybar
brew services restart wifisnitch
```

```bash
brew services stop easybar
brew services stop wifisnitch
```

## Upgrade

```bash
brew upgrade easybar-app/tap/easybar easybar-app/tap/wifisnitch
brew services restart easybar
brew services restart wifisnitch
```

## Remove

```bash
brew services stop easybar
brew services stop wifisnitch
brew uninstall easybar-app/tap/easybar easybar-app/tap/wifisnitch
```

## Source

- [easybar](https://github.com/easybar-app/easybar)
- [wifisnitch](https://github.com/gi8lino/wifisnitch)
