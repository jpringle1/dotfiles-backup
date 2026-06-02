# How they work
## Windows
`packages/setup.ps1` is the main script.
`setup.ps1` calls `symlinker.ps1` to handle symlinks. `symlinker.ps1` is basically just a library.
`setup.ps1` runs `symlinker` with `mappings-windows` and `mappings-linux`, this stows most of the packages into windows and wsl respectively.
It also runs any setup scripts that exist inside packages. These are only present in packages with more complex logic (yazi and rider). A package with a script can also be in the mappings.yaml as well, such as yazi, which is symlinked traditionally but also uses the setup script to set the file_one env var.

packages dir contains `mappings-windows.yaml` and `mappings-linux.yaml`, both of which contain destination paths for each folder and file in `/packages/`.

Has powershell-yaml module bundled locally so setup script can use without having to install (security perm issues prevent this).


## WSL
Logic is inside same setup.ps1 script that runs windows symlinks.
Instead of running th windows symlink, the paht is converted to wsl, and the symlink command is run from wsl

## Linux
- Not finished
- Loop through every package
    - if package has install script, run script
    - else, if package has .stow-dir.yaml, symlink package to value in .stow-dir
    - else, (If package has no .stow-dir.yaml), symlink package to /config

Most packages have no .stow-dir, and the whole package dir gets symlinked to /config with no additional logic.

If a package needs to be symlinked to a directory other than /config, or just needs to use a different dir name in /config, then a .stow-file.yaml will exist containing the destination path.

Packages that have more complex symlinks (needs to be symlinked to multiple destinations, needs certain files symlinked, etc), have an install script that handles their logic instead of using the .stow-dir.yaml


# Plan
I think the windows way of managing symlinks is the most robust. Instead of looping through package directories, simply have a mappings.yaml file listing all the directories i want to symlink and their destinations.

Then, i can have three mappings files: one for linux, one for windows, one for wsl. And other 

## File structure
setup/
    - linux/
        - packages.yaml
        - setup-scripts.yaml
        - `setup.go`
        - `setup`
    - windows/
        - packages.yaml
        - setup-scripts.yaml
        - `setup.ps1`
        - `symlinker-windows.ps1`
    - wsl/
        - packages.yaml
        - setup-scripts.yaml
        - `setup.go`
        - `setup`
    - shared/
        - `symlinker-linux`
packages/
    - package1
    - package2
    - package3
    - file1
    - file2
    - file3
    - lin-file1
    - lin-file2
    - lin-file3
    - wsl-file1
    - wsl-file2
    - wsl-file3
    - win-file1
    - win-file2
    - win-file3
