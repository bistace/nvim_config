# nvim_config

Color scheme: https://github.com/marciomazza/vim-brogrammer-theme

## Required python modules for pylsp
```
pip install "python-lsp-server[all]"
pip install python-lsp-isort
pip install pylsp-mypy
pip install python-lsp-black
```

## D language support
Add a file `serve-d` in `~/.local/share/nvim/mason/bin` which contains the last version of the
`serve-d` language server (Mason version is 0.7.6 and buggy).
