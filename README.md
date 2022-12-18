# vim-neovim config

> https://www.youtube.com/watch?v=vdn_pKJUda8&t=398s

## Installation

### Linux

installation using snap

```
sudo snap install --beta nvim --classic

```

> Make sure to install > 0.8 version.

_source: https://github.com/neovim/neovim/wiki/Installing-Neovim_

#### configuration tree

```
~/.config/
  |__nvim/
    |__init.lua
    |__lua/
      |__vincent
        |__core/
          |__colorscheme.lua
          |__options.lua
          |__keymaps.lua
        |__plugins/
          |__lualine.lua
          |__telescope.lua
          |__nvim-tree.lua
          |__...
        |__plugins-setup.lua
```

### Windows

## Basic Options & Settings

### installation

import **core/options.lua** file inside **init.lua** file.

```
require("vincent.core.options")
```

### configuration

**options.lua**

configuration of basic elements such as indentation, tab, line numbers, ...
refer to content for more informations.

## Packer Plugin Manager

### installation

_source: https://github.com/wbthomason/packer.nvim_

code should be place in **plugins-setup.lua** to make sure packer-nvim is installed and correctly set.

import of this file has to be done in top of the **init.lua** file.

```
require("vincent.plugins-setup")
```

### configuration

```
-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  print("packer not found!")
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")
end)
```

## Colorscheme Setup

Source of existing colorschemes:
https://github.com/topics/neovim-colorscheme

### installation

Install the git repository using packer.

```
-- add list of plugins to install
return packer.startup(function(use)
  [...]

  -- colorschemes
  use("bluz71/vim-nightfly-guicolors")

  [...]
end)
```

Import the **core/colorscheme.lua** file in the **init.lua** file.

```
require("vincent.core.colorscheme")
```

### configuration

Update the **core/colorscheme.lua** file to execute the vim command to activate the colorscheme. (safe import)

```
local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
  print("Colorscheme not found!")
  return
end
```

## Custom Keymaps

### installation

Import the **core/keymaps.lua** file in the **init.lua** file.

```
require("vincent.core.keymaps")
```

### configuration

> leader key = key to defined keymaps or shortcut that will not interfer with standard vim commands.

Update the **core/keymaps.lua**.
configuration of generic keymaps or other keymaps related to specific plugins.
refer to content for more informations.

```
local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
  print("Colorscheme not found!")
  return
end
```

## Window Related Plugins

1. split window navigation - use hjkl to navigate through different windows. https://github.com/christoomey/vim-tmux-navigator
2. maximizes current window (and revert) : https://github.com/szw/vim-maximizer

### installation

Add to **plugins-setup.lua**

```
  -- tmux & split window navigation
  use("christoomey/vim-tmux-navigator")

  -- maximizes and restores current window
  use("szw/vim-maximizer")
```

### configuration

Update **core/keymaps.lua** to add related keymaps.
See file for commands.

## Essential Plugins

1. vim-surrond : add, delete, change surroundings (it's awesome)
2. ReplaceWithRegister : replace with register contents using motion (gr + motion)

### installation

Add to **plugins-setup.lua**

```
	use("tpope/vim-surround")
	use("vim-scripts/ReplaceWithRegister")
```

### Usage

refer to repository for usage description :

- https://github.com/tpope/vim-surround
- https://github.com/vim-scripts/ReplaceWithRegister

## Commenting Plugin

commenting with gc

### installation

Add to **plugins-setup.lua**

```
use("numToStr/Comment.nvim")
```

### configuration

Create a file **plugins/comment.lua**

```
-- import comment plugin safely
local setup, comment = pcall(require, "Comment")
if not setup then
  print("Comment not found!")
	return
end

-- enable comment
comment.setup()
```

Import the **plugins/comment.lua** file in the **init.lua** file.

```
require("vincent.plugins.comment")
```

### usage

refer to repository for usage description :

- https://github.com/numToStr/Comment.nvim

## Plenary Plugin

### installation

Add to **plugins-setup.lua**

```
use("nvim-lua/plenary.nvim")
```

## Nvim-Tree File Explorer

### installation

Add to **plugins-setup.lua**

```
use("nvim-tree/nvim-tree.lua")
```

### configuration

Create a file **plugins/nvim-tree.lua**. Add content to safely import the plugin, add recommended setup and basic or custom setup.

https://github.com/nvim-tree/nvim-tree.lua

```
-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  print("nvim-tree not found!")
	return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
```

Import the **plugins/nvim-tree.lua** file in the **init.lua** file.

```
require("vincent.plugins.nvim-tree")
```

Add relative keymaps to **core/keymaps.lua**.

## VS Code Like Icons

https://github.com/nvim-tree/nvim-web-devicons

### installation

Add to **plugins-setup.lua**

```
use("kyazdani42/nvim-web-devicons")
```

## Lualine Statusline

https://github.com/nvim-lualine/lualine.nvim

### installation

Add to **plugins-setup.lua**

```
use("nvim-lualine/lualine.nvim")
```

### configuration

Create a file **plugins/lualine.lua** to perform a safe import of the plugin and add the custom configurations.

```
-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  print("lualine not found!")
  return
end

lualine.setup()
```

Import the **plugins/lualine.lua** file in the **init.lua** file.

```
require("vincent.plugins.lualine")
```

## Telescope Fuzzy Finder

https://github.com/nvim-telescope/telescope.nvim

### installation

Add to **plugins-setup.lua**

```
use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
use({ "nvim-telescope/telescope.nvim", branch = "0.1.x",
```

### configuration

Create a file **plugins/telescope.lua** to perform a safe import of the plugin and add the custom configurations.

```
-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  print("lelescope not found!")
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  print("telescope.actions not found!")
  return
end

-- import live-grep action safely
local lga_actions_setup, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not lga_actions_setup then
  print("telescope-live-grep not found!")
  return
end
```

Import the **plugins/telescope.lua** file in the **init.lua** file.

```
require("vincent.plugins.telescope")
```

## Basic Autocompletion

1. nvim-cmp

### installation

Add to **plugins-setup.lua**

```
-- autocompletion
use("hrsh7th/nvim-cmp") -- completion plugin
use("hrsh7th/cmp-buffer") -- source for text in buffer
use("hrsh7th/cmp-path") -- source for file system paths

-- snippets
use("L3MON4D3/LuaSnip") -- snippet engine
use("saadparwaiz1/cmp_luasnip") -- for autocompletion
use("rafamadriz/friendly-snippets") -- useful snippets
```

### configuration

Create a file **plugins/nvim-cmp.lua** to perform a safe import of the plugin and add the custom configurations.

```

```

Import the **plugins/nvim-cmp.lua** file in the **init.lua** file.

```
require("vincent.plugins.nvim-cmp")
```

## Configuring LSP

> https://www.youtube.com/watch?v=vdn_pKJUda8&t=2717s

https://github.com/williamboman/mason-lspconfig.nvim

### usage

> https://www.youtube.com/watch?v=vdn_pKJUda8&t=3387s

## Formatting & Linting

## Treesitter Highlighting & Autoclosing

## Git Integration
