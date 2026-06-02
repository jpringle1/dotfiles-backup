distribution_dir="/usr/lib64/firefox/distribution"
mozillaConfigDir="$HOME/.config/mozilla"
firefoxPackageDir="$HOME/.dotfiles/packages/firefox"
policiesfile='policies.json'

target="$firefoxPackageDir/$policiesfile"
destination="$distribution_dir/$policiesfile"

sudo rm -rf "$mozillaConfigDir"
sudo mkdir -p "$distribution_dir"
sudo rm "$destination"
sudo ln -s "$target" "$destination"

