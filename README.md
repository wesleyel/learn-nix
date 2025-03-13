# Nix Home Manager 配置

这是一个使用 flake 管理的 Nix Home Manager 配置，主要用于安装和配置 Git 以及其他常用工具。采用模块化设计，方便扩展和管理。

## 前提条件

- 已安装 Nix 包管理器
  ```sh
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```
- 已启用 flakes 功能（Determinate Nix默认启用，否则在 `~/.config/nix/nix.conf` 或 `/etc/nix/nix.conf` 中添加 `experimental-features = nix-command flakes`）

## 使用方法

### 初始化

首次使用时，请执行以下命令：

```bash
# 克隆仓库（如果是从GitHub等平台克隆）
# git clone <仓库URL> ~/.config/home-manager
# cd ~/.config/home-manager

# 构建并激活配置 -- work
nix build --no-link .#homeConfigurations.work.activationPackage
"$(nix path-info .#homeConfigurations.work.activationPackage)"/activate

# 构建并激活配置 -- personal
nix build --no-link .#homeConfigurations.personal.activationPackage
"$(nix path-info .#homeConfigurations.personal.activationPackage)"/activate
```

### 更新配置

修改配置文件后，执行以下命令应用更改：

```bash
home-manager switch --flake .#work --impure
```

## 自定义

### 添加新模块

1. 在 `modules/` 目录下创建新的模块文件，如 `vim.nix`
2. 在 `modules/default.nix` 中添加对新模块的引用
3. 重新应用配置

### 添加新的配置集合

1. 在 `configurations/` 下创建新的目录和配置
2. 在 `flake.nix` 的 `homeConfigurations` 中添加新的配置 